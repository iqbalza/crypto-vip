//
//  TopListPresenter.swift
//  crypto-vip
//
//  Created by Iqbal Zauqul Adib on 25/12/21.
//
import Foundation

protocol TopListPresentationLogic {
    func presentTopList(response: TopListModels.FetchTopList.Response)
    func presentPriceChangeUpdate(response: TopListModels.SubscribePriceChange.Response)
}

final class TopListPresenter {
    
    weak var viewController: TopListDisplayLogic?
    
    init(viewController: TopListDisplayLogic) {
        self.viewController = viewController
    }
    
    private func getDisplayedTopList(topLists: [TopListModels.ResponseTopList]?) -> [TopListModels.DisplayedTopList]? {
        guard let topLists = topLists else {
           return nil
        }
        
        let displayedTopLists: [TopListModels.DisplayedTopList] =  topLists.map { (topList) -> TopListModels.DisplayedTopList in
            var totalPriceChange: String? = nil
            var price: String? = nil
            
            
            //if coin has price
            if !topList.hasEmptyPrice {
                let formattedPrice = formatPrice(price: topList.price!, priceChange: topList.priceChange!, priceChangePct: topList.priceChangePct!, isNegative: topList.isNegative!)
                price = formattedPrice.price
                totalPriceChange = formattedPrice.priceChangeTotal
            }
            
            let displayedTopList = TopListModels.DisplayedTopList(
                name: topList.name,
                fullName: topList.fullName,
                price: price,
                priceChange: totalPriceChange,
                isNegative: topList.isNegative,
                hasEmptyPrice: topList.hasEmptyPrice
            )
            return displayedTopList
        }
        return displayedTopLists
    }
    
    private func formatPrice(price: Double, priceChange: Double, priceChangePct: Double, isNegative: Bool) -> (price: String, priceChangeTotal: String) {
        var priceChangeFormatted = String(format:"%.2f", priceChange)
        priceChangeFormatted = isNegative ? priceChangeFormatted : "+\(priceChangeFormatted)"
        var priceChangePctFormatted = String(format:"%.2f", priceChangePct)
        priceChangePctFormatted = isNegative ? priceChangePctFormatted + "%" : "+" + priceChangePctFormatted + "%"
        let priceChangeTotal = "\(priceChangeFormatted)(\(priceChangePctFormatted))"
        
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.numberStyle = .currency
        if (price < 1) {
            formatter.minimumFractionDigits = 4
        }
        let priceFormatted = formatter.string(from: price as NSNumber)
        

        
        return (price: priceFormatted!,priceChangeTotal: priceChangeTotal)
    }
    
}

extension TopListPresenter: TopListPresentationLogic {
    func presentTopList(response: TopListModels.FetchTopList.Response) {
        let viewModel = TopListModels.FetchTopList.ViewModel(error: response.error, displayedTopLists: self.getDisplayedTopList(topLists: response.responseTopLists))
            self.viewController?.displayTopLists(viewModel: viewModel)
    }
    func presentPriceChangeUpdate(response: TopListModels.SubscribePriceChange.Response) {
        let formattedPrice = formatPrice(price: response.updatedTopList.price!, priceChange: response.updatedTopList.priceChange!, priceChangePct: response.updatedTopList.priceChangePct!, isNegative: response.updatedTopList.isNegative!)
        
        let displayedTopList = TopListModels.DisplayedTopList(name: response.updatedTopList.name, fullName: response.updatedTopList.fullName, price: formattedPrice.price, priceChange: formattedPrice.priceChangeTotal, isNegative: response.updatedTopList.isNegative, hasEmptyPrice: response.updatedTopList.hasEmptyPrice)
        
        let viewModel = TopListModels.SubscribePriceChange.ViewModel(index: response.index, displayedTopList: displayedTopList)
        
        self.viewController?.displayPriceChangeUpdate(viewModel: viewModel)
    }
}
