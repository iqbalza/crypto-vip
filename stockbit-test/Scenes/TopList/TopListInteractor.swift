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
    var topList: [TopList]? {get}
}

final class TopListInteractor: TopListBusinessLogic, TopListDataStore {
    
    var topList: [TopList]?
    
    var presenter: TopListPresentationLogic

    var service: TopListServiceProtocol
    
    init(service: TopListServiceProtocol, presenter: TopListPresentationLogic) {
        self.service = service
        self.presenter = presenter
    }
    
    func fetchTopList(request: TopListModels.FetchTopList.Request) {
        service.fetchTopList { [weak self] result in
            switch result {
            case .success(let topListResponse):
                let toplist = topListResponse.data
                self?.presenter.presentTopList(response: TopListModels.FetchTopList.Response(toplist: toplist,isError: false, message: nil))
            case .failure(let error):
                self?.presenter.presentTopList(response: TopListModels.FetchTopList.Response(toplist: nil,isError: true, message: error.localizedDescription))
            }
        }
    }
}
