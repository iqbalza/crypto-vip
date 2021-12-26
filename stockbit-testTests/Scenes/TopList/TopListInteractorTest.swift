//
//  TopListInteractorTest.swift
//  stockbit-testTests
//
//  Created by Iqbal Zauqul Adib on 25/12/21.
//

import XCTest
@testable import stockbit_test
class TopListInteractorTest: XCTestCase {

    var sut: TopListInteractor!

    func testFetchTopList() {
        //given
        let mockTopListsService = TopListsServiceMock()
        let topListPresentationLogicSpy = TopListPresentationLogicSpy()
        let sut = TopListInteractor(service: mockTopListsService,presenter: topListPresentationLogicSpy)
        
        //when
        sut.fetchTopList(request: TopListModels.FetchTopList.Request())
        
        //then
        XCTAssertTrue(mockTopListsService.isFetchTopListCalled, "fetchTopList() should ask the service to fetch top lists")
        XCTAssert(topListPresentationLogicSpy.isPresentTopListsCalled, "fetchTopList() should ask the presenter to display top lists")
        XCTAssertEqual(topListPresentationLogicSpy.response?.toplist, mockTopListsService.successStub.data)
    }
    
    class TopListPresentationLogicSpy: TopListPresentationLogic {
        var isPresentTopListsCalled = false
        var response: TopListModels.FetchTopList.Response?
        
        func presentTopList(response: TopListModels.FetchTopList.Response) {
            isPresentTopListsCalled = true
            self.response = response
        }
    }
    
    class TopListsServiceMock: TopListServiceProtocol {
        
        var isFetchTopListCalled = false
        
        var successStub = Stubs.TopListResponseStub.successResponse
        
        func fetchTopList(completion: @escaping (Result<TopListResponse, APIErrorResult>) -> ()) {
            completion(.success(successStub))
            isFetchTopListCalled = true

        }
        
        
    }
    
    
}
