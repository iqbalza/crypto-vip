//
//  TopListPresenter.swift
//  stockbit-test
//
//  Created by Iqbal Zauqul Adib on 25/12/21.
//

import Foundation

protocol TopListPresentationLogic {
    func presentTopList(response: TopListModels.FetchTopList.Response)
}

final class TopListPresenter: TopListPresentationLogic {
    
    var viewController: TopListDisplayLogic?
    
    func presentTopList(response: TopListModels.FetchTopList.Response) {
        
        DispatchQueue.main.async { [weak self] in
            let viewModel = TopListModels.FetchTopList.ViewModel(error: response.error, displayedTopLists: self?.getDisplayedTopList(topLists: response.toplist))
            self?.viewController?.displayTopLists(viewModel: viewModel)
        }
    }
  
    func getDisplayedTopList(topLists: [TopList]?) -> [TopListModels.DisplayedTopList]? {
        guard let topLists = topLists else {
           return nil
        }
        
        
        let displayedTopLists: [TopListModels.DisplayedTopList] =  topLists.map { (topList) -> TopListModels.DisplayedTopList in
            
            let isNegative = topList.raw.usd.changeHour.sign == .minus
            
            var priceChange = String(format:"%.2f", topList.raw.usd.changeHour)
            priceChange = isNegative ? priceChange : "+\(priceChange)"
            
            var priceChangePercent = String(format:"%.2f", topList.raw.usd.changepctHour)
            priceChangePercent = priceChangePercent + "%" 
            
            let totalPriceChange = "\(priceChange) (\(priceChangePercent))"
            
            let price = String(format: "%.2f", topList.raw.usd.price)
            
            let displayedTopList = TopListModels.DisplayedTopList(
                name: topList.coinInfo.name,
                fullName: topList.coinInfo.fullName,
                price: price,
                priceChange: totalPriceChange,
                isNegative: isNegative
                
            )
            return displayedTopList
        }
        return displayedTopLists
    }
    
}
