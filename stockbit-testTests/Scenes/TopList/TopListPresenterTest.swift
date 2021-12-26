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
        
        let topList = TopListSceneStub.TopListsStub.all
        let response = TopListModels.FetchTopList.Response(toplist: topList, error: nil)
        sut.presentTopList(response: response)
        
        //then
        wait(for: [expectation], timeout: 5)
        XCTAssertTrue(topListViewControllerSpy.viewModel?.error==nil)
        XCTAssertTrue(topListViewControllerSpy.viewModel!.displayedTopLists != nil)
        XCTAssertEqual(topListViewControllerSpy.viewModel!.displayedTopLists, expectedDisplayedTopList)
        
    }
    
    class TopListViewSpy: TopListDisplayLogic {
        var isDisplayTopListCalled: (() -> Void)?
        var viewModel: TopListModels.FetchTopList.ViewModel?
        
        func displayTopLists(viewModel: TopListModels.FetchTopList.ViewModel) {
            self.isDisplayTopListCalled?()
            self.viewModel = viewModel
        }
        
        
        
        
    }
    
    
    
}
