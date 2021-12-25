//
//  TopListService.swift
//  stockbit-test
//
//  Created by Iqbal Zauqul Adib on 25/12/21.
//

import Foundation

protocol TopListServiceProtocol {
    func fetchTopList(completion: @escaping (Result<TopListResponse,APIErrorResult>)->() )
}

struct TopListService: TopListServiceProtocol {
    
    func fetchTopList(completion: @escaping (Result<TopListResponse,APIErrorResult>)->() ) {
        APIManager.shared.execute(endpoint: Endpoint.getTopList(limit:"50",currency: "USD"),completion: completion)
    }
}
