//
//  NewsService.swift
//  stockbit-test
//
//  Created by Iqbal Zauqul Adib on 26/12/21.
//

import Foundation

protocol NewsServiceProtocol {
    func fetchNews(category:String, completion: @escaping (Result<NewsResponse,APIErrorResult>)->() )
}

struct NewsService: NewsServiceProtocol {
    
    private init() {}
    
    static let shared = NewsService()
    
    func fetchNews(category:String, completion: @escaping (Result<NewsResponse,APIErrorResult>)->() ) {
        APIManager.shared.execute(endpoint: Endpoint.getNews(category:category), completion: completion)
    }
}
