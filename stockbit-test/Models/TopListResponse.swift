//
//  TopListResponse.swift
//  stockbit-test
//
//  Created by Iqbal Zauqul Adib on 25/12/21.
//

import Foundation

// MARK: - TopListResponse


struct TopListResponse: Codable {
    let message: String
    let type: Int
    let data: [TopList]
    let response: String?
    
   private enum CodingKeys: String, CodingKey {
            case message = "Message"
            case type = "Type"
            case data = "Data"
            case response = "Response"
        }
}

struct TopList: Codable {
    let coinInfo: CoinInfo
    let raw: Raw
    
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
    let changeHour: Double
    let changepctHour: Double
    
    private enum CodingKeys: String, CodingKey {
            case price = "PRICE"
            case changeHour = "CHANGEHOUR"
            case changepctHour = "CHANGEPCTHOUR"
         }
}
