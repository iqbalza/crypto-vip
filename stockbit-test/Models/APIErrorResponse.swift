//
//  APIErrorResponse.swift
//  stockbit-test
//
//  Created by Iqbal Zauqul Adib on 25/12/21.
//

import Foundation

struct APIErrorResponse: Codable {
    let message: String
    let type: Int
    let response: String?
    
   private enum CodingKeys: String, CodingKey {
            case message = "Message"
            case type = "Type"
            case response = "Response"
        }
}
