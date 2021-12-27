//
//  TopListResponse.swift
//  stockbit-test
//
//  Created by Iqbal Zauqul Adib on 25/12/21.
//

import Foundation

// MARK: - TopListResponse


struct TopListResponse: Codable {
    let data: [TopList]
    
   private enum CodingKeys: String, CodingKey {
            case data = "Data"
        }
}

struct TopList: Codable {
    let coinInfo: CoinInfo
    let raw: Raw?
    
    private enum CodingKeys: String, CodingKey {
             case coinInfo = "CoinInfo"
             case raw = "RAW"
         }
}

// MARK: - CoinInfo
struct CoinInfo: Codable {
    let id: String
    let name: String
    let fullName: String
    
    private enum CodingKeys: String, CodingKey {
             case id = "Id"
             case name = "Name"
             case fullName = "FullName"
         }
}


// MARK: - Raw
struct Raw: Codable{
    let usd: RawUsd
    
    private enum CodingKeys: String, CodingKey {
             case usd = "USD"
         }
}

// MARK: - RawUsd
struct RawUsd:Codable {
    let price: Double
    let open24Hour: Double
    
    private enum CodingKeys: String, CodingKey {
            case price = "PRICE"
            case open24Hour = "OPEN24HOUR"
         }
}


