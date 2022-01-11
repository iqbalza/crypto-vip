//
//  APIManager.swift
//  crypto-vip
//
//  Created by Iqbal Zauqul Adib on 25/12/21.
//

import Foundation

protocol APIManagerProtocol {
    func execute<T: Codable>( endpoint: Endpoint, completion: @escaping (Result<T, APIErrorResult>) -> () )
}

struct APIManager: APIManagerProtocol {
    
    static let shared = APIManager()
    
    private init() {}
    
    func execute<T: Codable>( endpoint: Endpoint, completion: @escaping (Result<T, APIErrorResult>) -> () )   {
        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.host = endpoint.baseURL
        components.path = endpoint.path
        components.queryItems = endpoint.query
        
        
        guard let url = components.url else {
            completion(.failure(APIErrorResult.invalidUrl))
            return
        }
        print(url)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method
//        urlRequest.allHTTPHeaderFields = endpoint.headers
        
        URLSession.shared.dataTask(with: urlRequest) { (data,response,error) in
            guard let data = data, let httpResponse = response as? HTTPURLResponse, error == nil else {
                //No data
                completion(.failure(APIErrorResult.serverError(error: "No Data")))
                print("\(String(describing: error))")
                return
            }
            
            guard 200...299 ~= httpResponse.statusCode else {
                completion(.failure(APIErrorResult.serverError(error: "Http Error: \(httpResponse.statusCode)")))
                let outputStr  = String(data: data, encoding: String.Encoding.utf8)
                print("\(endpoint.path) Error \(httpResponse.statusCode), \(String(describing: outputStr))")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch(let e) {
                print("Decoding Error: \(endpoint.path) ")
                print(String(describing:e))
                completion(.failure(decodeError(data: data)))
            }
        }.resume()
    }
    
    func decodeError(data: Data) -> APIErrorResult {
        do {
        let error = try JSONDecoder().decode(APIErrorResponse.self, from: data)
            return APIErrorResult.serverError(error: error.message)
            } catch(_) {
                return APIErrorResult.decodingFailed
            }
    }
    
}
