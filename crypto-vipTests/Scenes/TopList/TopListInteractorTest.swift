//
//  TopListInteractorTest.swift
//  crypto-vipTests
//
//  Created by Iqbal Zauqul Adib on 25/12/21.
//

import XCTest
@testable import crypto_vip
class TopListInteractorTest: XCTestCase {

    var sut: TopListInteractor!

    func testFetchTopList() {
        //given
        let mockTopListsService = TopListsServiceMock()
        let topListPresentationLogicSpy = TopListPresentationLogicSpy()
        let expectedResponse = TopListSceneStub.ResponseTopListsStub.all
        let sut = TopListInteractor(service: mockTopListsService,presenter: topListPresentationLogicSpy)
        
        //when
        sut.fetchTopList(request: TopListModels.FetchTopList.Request())
        
        //then
        XCTAssertTrue(mockTopListsService.isFetchTopListCalled)
        XCTAssert(topListPresentationLogicSpy.isPresentTopListsCalled)
        XCTAssert(topListPresentationLogicSpy.response?.error == nil)
        XCTAssertEqual(topListPresentationLogicSpy.response?.responseTopLists,expectedResponse)
    }
    
    func testSubscribeToLiveUpdate() {
        //given
        let mockLiveUpdateService = LiveUpdateServiceMock()
        let topListPresentationLogicSpy = TopListPresentationLogicSpy()
        let liveTickerResponse = LiveTickerResponse(type: "2", fromSymbol: "BTC", price: 200.00, open24Hour: 300.00)
        mockLiveUpdateService.liveTickerResponse = liveTickerResponse
        let sut = TopListInteractor(presenter: topListPresentationLogicSpy, liveUpdateService: mockLiveUpdateService)
        
        //when
        sut.fetchTopList(request: TopListModels.FetchTopList.Request())
        
        //then
        XCTAssertTrue(mockLiveUpdateService.isSubscribeCalled)
        XCTAssertTrue(topListPresentationLogicSpy.isPresentPriceChangeUpdateCalled)
        XCTAssertNotNil(topListPresentationLogicSpy.presentPriceChangeResponse)
        
    }
    
    class TopListPresentationLogicSpy: TopListPresentationLogic {
        
        var isPresentTopListsCalled = false
        var response: TopListModels.FetchTopList.Response?
        
        var isPresentPriceChangeUpdateCalled = false
        var presentPriceChangeResponse: TopListModels.SubscribePriceChange.Response?
        
        func presentTopList(response: TopListModels.FetchTopList.Response) {
            isPresentTopListsCalled = true
            self.response = response
        }
        
        func presentPriceChangeUpdate(response: TopListModels.SubscribePriceChange.Response) {
            isPresentPriceChangeUpdateCalled = true
            self.presentPriceChangeResponse = response
            
        }
    }
    
    class TopListsServiceMock: TopListServiceProtocol {
        
        var isFetchTopListCalled = false
        
        var successStub = TopListSceneStub.TopListResponseStub.successResponse
        
        func fetchTopList(completion: @escaping (Result<TopListResponse, APIErrorResult>) -> ()) {
            completion(.success(successStub))
            isFetchTopListCalled = true

        }
        
    }
    
    class LiveUpdateServiceMock: LiveUpdateServiceProtocol {
        
        var isSubscribeCalled = false
        
        var liveTickerResponse: LiveTickerResponse!
        
        func subscribe(subsId: [String], completion: @escaping ((LiveTickerResponse) -> Void)) {
            isSubscribeCalled = true
            completion(liveTickerResponse)
        }
        
        func unsubscribe() {
            
        }
        
        
    }
    
    
}
