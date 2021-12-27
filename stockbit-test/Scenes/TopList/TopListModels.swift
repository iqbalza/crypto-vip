//
//  TopListModels.swift
//  stockbit-test
//
//  Created by Iqbal Zauqul Adib on 25/12/21.
//

enum TopListModels {
    
    struct DisplayedTopList {
        let name: String
        let fullName: String
        var price: String?
        var priceChange: String?
        var isNegative: Bool?
        let hasEmptyPrice: Bool
    }
    
    struct ResponseTopList {
        let hasEmptyPrice: Bool
        let name: String
        let fullName: String
        let price: Double?
        let priceChangePct: Double?
        let priceChange: Double?
        let isNegative: Bool?
    }
    
    enum FetchTopList {
        struct Request {
        }
        struct Response {
            let responseTopLists: [ResponseTopList]?
            var error: APIErrorResult?
        }
        struct ViewModel {
            var error: APIErrorResult?
            var displayedTopLists: [DisplayedTopList]?
        }
    }
    
    enum SubscribePriceChange {
        
        struct Request {
            
        }
        
        struct Response {
            let updatedTopList: ResponseTopList
            let index: Int
        }
        
        struct ViewModel {
            let index: Int
            let displayedTopList: DisplayedTopList
        }
    }
}
