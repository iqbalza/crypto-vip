//
//  Endpoint.swift
//  stockbit-test
//
//  Created by Iqbal Zauqul Adib on 25/12/21.
//

import Foundation

enum Endpoint {
    
    case getTopList(limit: String, currency: String )
    
    var baseURL: String {
        switch self {
        default:
            return "min-api.cryptocompare.com"
        }
    }
    
    var method: String {
        switch self {
        default:
            return "GET"
        }
    }
    
   
    var query: [URLQueryItem] {
        switch self {
        case .getTopList(let limit, let currency):
            return [
                URLQueryItem(name: "limit", value: limit),
                URLQueryItem(name: "tsym", value: currency)
            ]
        }
    }
    
    var path: String {
        switch self {
            
        case .getTopList(_, _):
            return "/data/top/totaltoptiervolfull"
       
        }
    }
    
    var scheme: String {
        switch self {
       
        default:
            return "https"
        }
    }
}
