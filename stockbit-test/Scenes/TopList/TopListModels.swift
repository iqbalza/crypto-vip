//
//  TopListModels.swift
//  stockbit-test
//
//  Created by Iqbal Zauqul Adib on 25/12/21.
//

import Foundation

enum TopListModels {
    
    struct DisplayedTopList {
        let name: String
        let fullName: String
        let price: String?
        let priceChange: String?
        let isNegative: Bool?
        let hasEmptyPrice: Bool
    }
    
    enum FetchTopList {
        struct Request {
        }
        struct Response {
            let toplist: [TopList]?
            var error: APIErrorResult?
        }
        struct ViewModel {
            var error: APIErrorResult?
            var displayedTopLists: [DisplayedTopList]?
        }
    }
}
