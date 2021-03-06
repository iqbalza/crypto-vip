//
//  TopListService.swift
//  crypto-vip
//
//  Created by Iqbal Zauqul Adib on 25/12/21.
//

protocol TopListServiceProtocol {
    func fetchTopList(completion: @escaping (Result<TopListResponse,APIErrorResult>)->() )
}

struct TopListService: TopListServiceProtocol {
    
    private init() {}
    
    static let shared = TopListService()
    
    func fetchTopList(completion: @escaping (Result<TopListResponse,APIErrorResult>)->() ) {
        APIManager.shared.execute(endpoint: Endpoint.getTopList(limit:"50",currency: "USD"),completion: completion)
    }
}
