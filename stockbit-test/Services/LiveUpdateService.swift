//
//  WebSocket.swift
//  stockbit-test
//
//  Created by Iqbal Zauqul Adib on 26/12/21.
//

import Starscream

protocol LiveUpdateServiceProtocol{
    func subscribe(subsId: [String], completion: @escaping ((LiveTickerResponse)->Void))
    func unsubscribe()
}

class LiveUpdateService: LiveUpdateServiceProtocol {
        
    var socket: WebSocket?
    
    private init() {}
    
    static let shared = LiveUpdateService()
    
    func subscribe(subsId: [String], completion: @escaping ((LiveTickerResponse)->Void) ) {
        
        let subs = subsId.map { sub in
            return "2~Coinbase~\(sub)~USD"
        }
        let key = "03a65d75225a3a323368a5d6ad4c17584deecd946a1fbdfcb6618ff8df3dde98"
        var request = URLRequest(url: URL(string: "wss://streamer.cryptocompare.com/v2?api_key=\(key)")!)
        socket = WebSocket(request: request)
        
        socket?.onEvent = { [weak self] event in
            switch event {
                case .connected(let headers):
                print("websocket is connected: \(headers)")
                let liveTickerSub = LiveTickerSub(action: "SubAdd", subs: subs)
                let data = try! JSONEncoder().encode(liveTickerSub)
                self?.socket?.write(data: data)
                    
                case .disconnected(let reason, let code):
                    print("websocket is disconnected: \(reason) with code: \(code)")
                
                case .text(let string):
                print("Received text: \(string)")
                guard let data = self?.handleData(dataString: string) else {
                    return
                }
                completion(data)
                
                case .binary(let data):
                    print("Received data: \(data.count)")
                
                case .ping(_):
                print("ping")

                case .pong(_):
                print("pong")

                case .viabilityChanged(_):
                print("viability")

                case .reconnectSuggested(_):
                print("reconnect")

                case .cancelled:
                print("cancelled")
                
                case .error(let error):
                print("Error: \(String(describing: error))")
                }
        }
        
        request.timeoutInterval = 10
        socket?.connect()

    }
    
    func handleData(dataString: String) -> LiveTickerResponse? {
    guard let dataRaw = dataString.data(using: .utf8) else {
        print("Failed dataraw")
        return nil
    }

    guard let data = try? JSONDecoder().decode(LiveTickerResponse.self, from: dataRaw) else {
        return nil
    }
        return data
    }
    
    func unsubscribe() {
        socket?.disconnect()
    }
    
    deinit {
        unsubscribe()
        print("Disconnected")
    }
    
    
    
}
