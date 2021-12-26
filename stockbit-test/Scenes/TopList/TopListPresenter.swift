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
    
    var viewController: TopListDisplayLogic
    
    init(viewController: TopListDisplayLogic) {
        self.viewController = viewController
    }
    
    func presentTopList(response: TopListModels.FetchTopList.Response) {
            let viewModel = TopListModels.FetchTopList.ViewModel(error: response.error, displayedTopLists: self.getDisplayedTopList(topLists: response.toplist))
            self.viewController.displayTopLists(viewModel: viewModel)
    }
  
   private func getDisplayedTopList(topLists: [TopList]?) -> [TopListModels.DisplayedTopList]? {
        guard let topLists = topLists else {
           return nil
        }
        
        let displayedTopLists: [TopListModels.DisplayedTopList] =  topLists.map { (topList) -> TopListModels.DisplayedTopList in
            var hasEmptyPrice = true
            var priceChange: String? = nil
            var totalPriceChange: String? = nil
            var price: String? = nil
            var isNegative: Bool? = nil
            
            //if coin has price
            if let raw = topList.raw {
                hasEmptyPrice = false
                isNegative = raw.usd.changeHour.sign == .minus
                priceChange = String(format:"%.2f", raw.usd.changeHour)
                priceChange = isNegative! ? priceChange : "+\(priceChange!)"
                var priceChangePct = String(format:"%.2f", raw.usd.changepctHour)
                priceChangePct = isNegative! ? priceChangePct + "%" : "+" + priceChangePct + "%"
                totalPriceChange = "\(priceChange!)(\(priceChangePct))"
                price = String(format: "%.2f", raw.usd.price)
            }
            
            let displayedTopList = TopListModels.DisplayedTopList(
                name: topList.coinInfo.name,
                fullName: topList.coinInfo.fullName,
                price: price,
                priceChange: totalPriceChange,
                isNegative: isNegative,
                hasEmptyPrice: hasEmptyPrice
            )
            return displayedTopList
        }
        return displayedTopLists
    }
    
}
