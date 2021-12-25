//
//  Stubs.swift
//  stockbit-testTests
//
//  Created by Iqbal Zauqul Adib on 25/12/21.
//


@testable import stockbit_test

struct Stubs {
    struct TopLists {
        static let btc = TopList(coinInfo: CoinInfo(id: "", name: "BTC", fullName: "Bitcoin"),
                                 raw: Raw(usd: RawUsd(price: 800.000, changeHour: 96.79, changepctHour: 0.19)),
                                 display: Display(usd: DisplayUsd(price: <#T##String#>, changeHour: <#T##String#>, changepctHour: <#T##String#>)))
    }
}
