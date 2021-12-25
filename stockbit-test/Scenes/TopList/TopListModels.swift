//
//  TopListModels.swift
//  stockbit-test
//
//  Created by Iqbal Zauqul Adib on 25/12/21.
//

import Foundation

enum TopListModels {
    enum FetchTopList {
        struct Request {
            
        }
        struct Response {
            let toplist: [TopList]?
            let isError: Bool
            let message: String?
        }
        struct ViewModel {
            struct TopList {
                let name: String
                let fullName: String
                let price: String
                let priceChange: Double
                let priceChangePercent: Double
            }
        }
    }
}
