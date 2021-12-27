//
//  TopListInteractor.swift
//  stockbit-test
//
//  Created by Iqbal Zauqul Adib on 25/12/21.
//

import Foundation

protocol TopListBusinessLogic {
    func fetchTopList(request: TopListModels.FetchTopList.Request)
}

protocol TopListDataStore {
    var topLists: [TopList]? {get}
}

final class TopListInteractor: TopListDataStore {
    
    var topLists: [TopList]?
    var presenter: TopListPresentationLogic
    var service: TopListServiceProtocol
    var liveUpdateService: LiveUpdateServiceProtocol
    
    
    init(service: TopListServiceProtocol = TopListService.shared, presenter: TopListPresentationLogic,liveUpdateService:  LiveUpdateServiceProtocol = LiveUpdateService.shared) {
        self.service = service
        self.presenter = presenter
        self.liveUpdateService = liveUpdateService
    }
    
    private func calculatePriceChanges(currentPrice: Double, openHourPrice: Double)
    -> (priceChange: Double, priceChangePct: Double, isNegative: Bool) {
                let priceChange = currentPrice-openHourPrice
                let priceChangePct = (priceChange/openHourPrice) * 100
                let isNegative = priceChange.sign == .minus
                return (priceChange,priceChangePct,isNegative)
            }
}

extension TopListInteractor: TopListBusinessLogic {
    func fetchTopList(request: TopListModels.FetchTopList.Request) {
        service.fetchTopList { [weak self] result in
            switch result {
            case .success(let topListResponse):
                let toplists = topListResponse.data
                self?.topLists = toplists
                
               let responseTopLists =  toplists.map{ (toplist) -> TopListModels.ResponseTopList in
                   
                   
                   guard let raw = toplist.raw else {
                       return TopListModels.ResponseTopList(hasEmptyPrice: true, name: toplist.coinInfo.name, fullName: toplist.coinInfo.fullName, price: nil, priceChangePct: nil, priceChange: nil, isNegative: nil)
                   }
                   
                   guard let calculatedPriceChange = self?.calculatePriceChanges(currentPrice: raw.usd.price, openHourPrice: raw.usd.open24Hour) else {
                       fatalError()
                   }
                    
                   return TopListModels.ResponseTopList(hasEmptyPrice: false, name: toplist.coinInfo.name, fullName: toplist.coinInfo.fullName, price: toplist.raw?.usd.price, priceChangePct: calculatedPriceChange.priceChangePct, priceChange: calculatedPriceChange.priceChange, isNegative: calculatedPriceChange.isNegative)
                }
                
                self?.presenter.presentTopList(response: TopListModels.FetchTopList.Response(responseTopLists: responseTopLists,error: nil))
                self?.subscribeToPriceChanges()
            case .failure(let error):
                self?.presenter.presentTopList(response: TopListModels.FetchTopList.Response(responseTopLists: nil, error: error))
            }
        }
    }
    
    func subscribeToPriceChanges() {
        liveUpdateService.unsubscribe()
        guard let topLists = topLists else {
            return
        }
        let subscribtionsId: [String] = topLists.map({ topList in
            return topList.coinInfo.name
        })
        liveUpdateService.subscribe(subsId: subscribtionsId) { [weak self] response in
            
            
            let indexToUpdate = topLists.firstIndex{$0.coinInfo.name == response.fromSymbol}
            let topListToUpdate = topLists[indexToUpdate!]
            var openHourPrice = topListToUpdate.raw?.usd.open24Hour
            
            if let newOpenHourPRice = response.open24Hour {
                    openHourPrice = newOpenHourPRice
            }
            
            let updatedPriceChanges = self?.calculatePriceChanges(currentPrice: response.price, openHourPrice: openHourPrice!)
            let isNegative = updatedPriceChanges?.priceChange.sign == .minus
            
            let updatedTopList = TopListModels.ResponseTopList(hasEmptyPrice: false, name: topListToUpdate.coinInfo.name, fullName: topListToUpdate.coinInfo.fullName, price: response.price, priceChangePct: updatedPriceChanges!.priceChangePct, priceChange: updatedPriceChanges!.priceChange, isNegative: isNegative)
            
            let response = TopListModels.SubscribePriceChange.Response(updatedTopList: updatedTopList,index: indexToUpdate!)
            self?.presenter.presentPriceChangeUpdate(response: response)
        }
    }
}
