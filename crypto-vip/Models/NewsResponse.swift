//
//  NewsResponse.swift
//  crypto-vip
//
//  Created by Iqbal Zauqul Adib on 26/12/21.
//

struct NewsResponse: Codable {
    let news: [News]
    
    private enum CodingKeys: String, CodingKey {
            case news = "Data"
         }
}

// MARK: - Datum
struct News: Codable {
    let title: String
    let source: String
    let body: String
}

