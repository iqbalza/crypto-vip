//
//  Stubs.swift
//  stockbit-testTests
//
//  Created by Iqbal Zauqul Adib on 25/12/21.
//


@testable import stockbit_test

struct Stubs {
    struct TopLists {
        static let btc = TopList(coinInfo: CoinInfo(id: "1182", name: "BTC", fullName: "Bitcoin"),
                                 raw: Raw(usd: RawUsd(price: 800.000, changeHour: -1.3900000000000006, changepctHour: -1.4141825211109986)))
        
        static let eth = TopList(coinInfo: CoinInfo(id: "1183", name: "BTC", fullName: "Ethereum"),
                                 raw: Raw(usd: RawUsd(price: 70.500, changeHour: 38.59999999999991, changepctHour: 0.9433132288683153)))
        
        static let ada = TopList(coinInfo: CoinInfo(id: "1184", name: "BTC", fullName: "Cardano"),
                                 raw: Raw(usd: RawUsd(price: 65.434, changeHour: -38.59999999999991, changepctHour: -0.9433132288683153)))
        static let all = [btc,eth,ada]
                                 
    }
}
