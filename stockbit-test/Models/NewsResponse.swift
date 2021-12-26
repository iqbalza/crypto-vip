//
//  NewsResponse.swift
//  stockbit-test
//
//  Created by Iqbal Zauqul Adib on 26/12/21.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let newsResponse = try? newJSONDecoder().decode(NewsResponse.self, from: jsonData)

import Foundation

// MARK: - NewsResponse
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

