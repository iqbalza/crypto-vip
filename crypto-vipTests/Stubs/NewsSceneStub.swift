//
//  NewsSceneStub.swift
//  crypto-vipTests
//
//  Created by Iqbal Zauqul Adib on 26/12/21.
//

@testable import crypto_vip

struct NewsSceneStub {
    struct NewsResponseStub {
        static let all = NewsResponse(news: [
            News(title: "BTC", source: "Source", body: "Body"),
            News(title: "ETH", source: "Source2", body: "Body2"),
            News(title: "ADA", source: "Source3", body: "Body3")
        ])
    }
    struct DisplayedNews {
        static let all = [
            NewsModels.DisplayedNews(title: "BTC", body: "Body", source: "Source"),
            NewsModels.DisplayedNews(title: "ETH", body: "Body2", source: "Source2"),
            NewsModels.DisplayedNews(title: "ADA", body: "Body3", source: "Source3")
        ]
    }
}

extension News: Equatable {
    public static func == (lhs: News, rhs: News) -> Bool {
         lhs.title == rhs.title &&
         lhs.source == rhs.source &&
         lhs.body == rhs.body
     }
}

extension NewsModels.DisplayedNews: Equatable {
    public static func == (lhs: NewsModels.DisplayedNews, rhs: NewsModels.DisplayedNews) -> Bool {
         lhs.title == rhs.title &&
         lhs.source == rhs.source &&
         lhs.body == rhs.body
     }
}
