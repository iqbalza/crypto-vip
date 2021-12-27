//
//  NewsModels.swift
//  stockbit-test
//
//  Created by Iqbal Zauqul Adib on 26/12/21.
//

enum NewsModels {
    
    struct DisplayedNews {
        let title: String
        let body: String
        let source: String
    }
    
    enum FetchNews {
        struct Request {
            let category: String
        }
        struct Response {
            let news: [News]?
            let error: APIErrorResult?
        }
        struct ViewModel {
            let displayedNews: [DisplayedNews]?
            let error: APIErrorResult?
        }
    }
}
