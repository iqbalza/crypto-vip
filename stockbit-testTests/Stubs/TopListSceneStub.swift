//
//  Stubs.swift
//  stockbit-testTests
//
//  Created by Iqbal Zauqul Adib on 25/12/21.
//


@testable import stockbit_test
import XCTest

struct TopListSceneStub {
    
    struct TopListResponseStub {
        static let successResponse =  TopListResponse(data: TopListSceneStub.TopListsStub.all)
    }
    
    struct TopListsStub {
        static let btc = TopList(coinInfo: CoinInfo(id: "1182", name: "BTC", fullName: "Bitcoin"),
                                 raw: Raw(usd: RawUsd(price: 800.000, changeHour: -1.3900000000000006, changepctHour: -1.4141825211109986)))

        static let eth = TopList(coinInfo: CoinInfo(id: "1183", name: "ETH", fullName: "Ethereum"),
                                 raw: Raw(usd: RawUsd(price: 70.500, changeHour: 38.59999999999991, changepctHour: 0.9433132288683153)))
        
        static let ada = TopList(coinInfo: CoinInfo(id: "1184", name: "ADA", fullName: "Cardano"),
                                 raw: Raw(usd: RawUsd(price: 65.434, changeHour: -38.59999999999991, changepctHour: -0.9433132288683153)))
        static let nft = TopList(coinInfo: CoinInfo(id: "1185", name: "NFT", fullName: "APENFT"),
                                 raw: nil)
        
        static let all = [btc,eth,ada,nft]
    }
    
    struct DisplayedTopListStub {
      static let displayedTopList =  [
            TopListModels.DisplayedTopList(name: "BTC", fullName: "Bitcoin", price: "800.00", priceChange: "-1.39(-1.41%)", isNegative: true, hasEmptyPrice: false),
            TopListModels.DisplayedTopList(name: "ETH", fullName: "Ethereum", price: "70.50", priceChange: "+38.60(+0.94%)", isNegative: false, hasEmptyPrice: false),
            TopListModels.DisplayedTopList(name: "ADA", fullName: "Cardano", price: "65.43", priceChange: "-38.60(-0.94%)", isNegative: true, hasEmptyPrice: false),
            TopListModels.DisplayedTopList(name: "NFT", fullName: "APENFT", price: nil, priceChange: nil, isNegative: nil, hasEmptyPrice: true)]
    }
    
}

extension TopList: Equatable {
    public static func == (lhs: TopList, rhs: TopList) -> Bool {
        lhs.coinInfo.id  == rhs.coinInfo.id &&
        lhs.coinInfo.fullName == rhs.coinInfo.fullName &&
        lhs.coinInfo.name == rhs.coinInfo.name &&
        lhs.raw?.usd.price == rhs.raw?.usd.price &&
        lhs.raw?.usd.changepctHour == rhs.raw?.usd.changepctHour &&
        lhs.raw?.usd.changeHour == rhs.raw?.usd.changeHour
    }
    
}

extension TopListModels.DisplayedTopList: Equatable {
   public static func == (lhs: TopListModels.DisplayedTopList, rhs: TopListModels.DisplayedTopList) -> Bool {
        lhs.hasEmptyPrice == rhs.hasEmptyPrice &&
        lhs.priceChange == rhs.priceChange &&
        lhs.price == rhs.price &&
        lhs.fullName == rhs.fullName &&
        lhs.name == rhs.name &&
        lhs.isNegative == rhs.isNegative
    }
}
