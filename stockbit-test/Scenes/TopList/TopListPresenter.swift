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
            let viewModel = TopListModels.FetchTopList.ViewModel(error: response.error, displayedTopLists: self?.getDisplayedTopList(topList: response.toplist))
            self?.viewController?.displayTopLists(viewModel: viewModel)
        }
    }
  
    func getDisplayedTopList(topList: [TopList]?) -> [TopListModels.DisplayedTopList]? {
        guard let topList = topList else {
           return nil
        }
        
        
        let displayedTopLists: [TopListModels.DisplayedTopList] =  topList.map { (coin) -> TopListModels.DisplayedTopList in
            let displayedTopList = TopListModels.DisplayedTopList(
                name: coin.coinInfo.name,
                fullName: coin.coinInfo.fullName,
                price: coin.display.usd.price,
                priceChange: coin.raw.usd.changeHour,
                priceChangePercent: coin.raw.usd.changepctHour
                
            )
            return displayedTopList
        }
        return displayedTopLists
    }
    
}
