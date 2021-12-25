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
        let topListViewModel: [TopListModels.FetchTopList.ViewModel.TopList] =  response.toplist!.map { (coin) -> TopListModels.FetchTopList.ViewModel.TopList in
            
            
            
            let viewModel = TopListModels.FetchTopList.ViewModel.TopList(
                name: coin.coinInfo.name,
                fullName: coin.coinInfo.fullName,
                price: coin.display.usd.price,
                priceChange: coin.raw.usd.change24Hour,
                priceChangePercent: coin.raw.usd.changepct24Hour
                
            )
            return viewModel
        }
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.successFetchedTopList(viewModel: topListViewModel)
        }
    }
    
}
