//
//  TopListPresenterTest.swift
//  stockbit-testTests
//
//  Created by Iqbal Zauqul Adib on 25/12/21.
//

import XCTest
@testable import stockbit_test
class TopListPresenterTest: XCTestCase {

    var sut: TopListPresenter!
    
    func testPresentTopList() {
        //given
        let topListViewControllerSpy = TopListViewSpy()
        let expectation = XCTestExpectation(description: "display top list should be called")
        let expectationClosure: (() -> Void) = {
            expectation.fulfill()
        }
        topListViewControllerSpy.isDisplayTopListCalled = expectationClosure
        sut = TopListPresenter(viewController: topListViewControllerSpy)
        
        //when
        let expectedDisplayedTopList = TopListSceneStub.DisplayedTopListStub.displayedTopList
        
        let topList = TopListSceneStub.ResponseTopListsStub.all
        let response = TopListModels.FetchTopList.Response(responseTopLists: topList, error: nil)
        sut.presentTopList(response: response)
        
        //then
        wait(for: [expectation], timeout: 5)
        XCTAssertTrue(topListViewControllerSpy.fetchTopListsViewModel?.error==nil)
        XCTAssertNotNil(topListViewControllerSpy.fetchTopListsViewModel!.displayedTopLists)
        XCTAssertEqual(topListViewControllerSpy.fetchTopListsViewModel!.displayedTopLists, expectedDisplayedTopList)
        
    }
    
    func testPresentPriceUpdate() {
        //given
        let topListViewControllerSpy = TopListViewSpy()
        let expectation = XCTestExpectation(description: "display price update should be called")
        let expectationClosure: (() -> Void) = {
            expectation.fulfill()
        }
        topListViewControllerSpy.isDisplayPriceChangeCalled = expectationClosure
        sut = TopListPresenter(viewController: topListViewControllerSpy)
        
        //when
        sut.presentPriceChangeUpdate(response: TopListModels.SubscribePriceChange.Response(updatedTopList: TopListSceneStub.ResponseTopListsStub.eth, index: 0))
        
        //then
        wait(for: [expectation], timeout: 5)
        XCTAssertNotNil(topListViewControllerSpy.displayPriceChangeViewModel?.displayedTopList)
    }
    
    class TopListViewSpy: TopListDisplayLogic {
       
        
        var isDisplayTopListCalled: (() -> Void)?
        var isDisplayPriceChangeCalled: (() -> Void)?
        var fetchTopListsViewModel: TopListModels.FetchTopList.ViewModel?
        var displayPriceChangeViewModel: TopListModels.SubscribePriceChange.ViewModel?
        
        func displayTopLists(viewModel: TopListModels.FetchTopList.ViewModel) {
            self.isDisplayTopListCalled?()
            self.fetchTopListsViewModel = viewModel
        }
        
        func displayPriceChangeUpdate(viewModel: TopListModels.SubscribePriceChange.ViewModel) {
            self.isDisplayPriceChangeCalled?()
            self.displayPriceChangeViewModel = viewModel
    }
}
}
