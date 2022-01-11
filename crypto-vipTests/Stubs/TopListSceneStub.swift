//
//  Stubs.swift
//  crypto-vipTests
//
//  Created by Iqbal Zauqul Adib on 25/12/21.
//


@testable import crypto_vip
import XCTest

struct TopListSceneStub {
    
    struct TopListResponseStub {
        static let successResponse =  TopListResponse(data: TopListSceneStub.TopListsStub.all)
    }
    
    struct TopListsStub {
        static let btc = TopList(coinInfo: CoinInfo(id: "1182", name: "BTC", fullName: "Bitcoin"),
                                 raw: Raw(usd: RawUsd(price: 800.000, open24Hour: 755.000)))

        static let eth = TopList(coinInfo: CoinInfo(id: "1183", name: "ETH", fullName: "Ethereum"),
                                 raw: Raw(usd: RawUsd(price: 70.500, open24Hour: 65.500)))
    
        static let all = [btc,eth]
    }
    
    struct ResponseTopListsStub {
        static let btc = TopListModels.ResponseTopList(hasEmptyPrice: false, name: TopListSceneStub.TopListsStub.btc.coinInfo.name, fullName: TopListSceneStub.TopListsStub.btc.coinInfo.fullName, price: TopListSceneStub.TopListsStub.btc.raw?.usd.price, priceChangePct: 5.960264900662252, priceChange: 45.000, isNegative: false)
        
        static let eth = TopListModels.ResponseTopList(hasEmptyPrice: false, name: TopListSceneStub.TopListsStub.eth.coinInfo.name, fullName: TopListSceneStub.TopListsStub.eth.coinInfo.fullName, price: TopListSceneStub.TopListsStub.eth.raw?.usd.price, priceChangePct: 7.633587786259542, priceChange: 5.00, isNegative: false)
        static let all = [btc,eth]
        
    }
    
    struct DisplayedTopListStub {
      static let displayedTopList =  [
            TopListModels.DisplayedTopList(name: "BTC", fullName: "Bitcoin", price: "$800.00", priceChange: "+45.00(+5.96%)", isNegative: false, hasEmptyPrice: false),
            TopListModels.DisplayedTopList(name: "ETH", fullName: "Ethereum", price: "$70.50", priceChange: "+5.00(+7.63%)", isNegative: false, hasEmptyPrice: false),
      ]
    }
    
}

extension TopList: Equatable {
    public static func == (lhs: TopList, rhs: TopList) -> Bool {
        lhs.coinInfo.id  == rhs.coinInfo.id &&
        lhs.coinInfo.fullName == rhs.coinInfo.fullName &&
        lhs.coinInfo.name == rhs.coinInfo.name &&
        lhs.raw?.usd.price == rhs.raw?.usd.price &&
        lhs.raw?.usd.open24Hour == rhs.raw?.usd.open24Hour
    }
    
}

extension TopListModels.ResponseTopList: Equatable {
    public static func == (lhs: TopListModels.ResponseTopList, rhs: TopListModels.ResponseTopList) -> Bool {
         lhs.hasEmptyPrice == rhs.hasEmptyPrice &&
         lhs.priceChange == rhs.priceChange &&
         lhs.price == rhs.price &&
         lhs.fullName == rhs.fullName &&
         lhs.name == rhs.name &&
         lhs.isNegative == rhs.isNegative
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

extension TopListModels.SubscribePriceChange.Response: Equatable {
    public static func == (lhs: TopListModels.SubscribePriceChange.Response, rhs: TopListModels.SubscribePriceChange.Response) -> Bool {
        lhs.index == rhs.index &&
        lhs.updatedTopList == rhs.updatedTopList
    }
    
    
}
