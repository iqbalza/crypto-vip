//
//  TopListViewTest.swift
//  stockbit-testTests
//
//  Created by Iqbal Zauqul Adib on 26/12/21.
//

import XCTest
@testable import stockbit_test

class TopListViewTest: XCTestCase {
    
    var sut: TopListViewController!
    var interactorSpy: InteractorSpy!
    
    override func setUp() {
        //given
        interactorSpy = InteractorSpy()
        sut = TopListViewController(interactor: interactorSpy)
        sut.loadViewIfNeeded()
    }

    func makeSUT() -> TopListViewController {
        
        return sut
    }
    
    func testFetchTopListShouldBeCalledWhenViewDidLoad() {
        //when
        sut.viewDidAppear(true)
        
        //then
        XCTAssertTrue(interactorSpy.isFetchTopListCalled)
    }
    
    func testShouldDisplayFethcedTopLists() {
        //given
        let tableViewSpy = TableViewSpy()
        sut.tableView = tableViewSpy
        let displayedTopLists: [TopListModels.DisplayedTopList] = []
        let viewModel = TopListModels.FetchTopList.ViewModel(error: nil, displayedTopLists: displayedTopLists)
        let tableViewShouldReloadExp = XCTestExpectation(description: "view should reload tableview")
        let tableViewSpyClosure: (()->Void) = {
            tableViewShouldReloadExp.fulfill()
        }
        tableViewSpy.reloadDataCalledClosure = tableViewSpyClosure
        
        //when
        sut.displayTopLists(viewModel: viewModel)
        
        //then
        wait(for: [tableViewShouldReloadExp], timeout: 5)
    }
    
    
    
    class InteractorSpy: TopListBusinessLogic {
        var isFetchTopListCalled = false
        
        func fetchTopList(request: TopListModels.FetchTopList.Request) {
            isFetchTopListCalled = true
        }

    }
    
    class TableViewSpy: UITableView {
        var reloadDataCalledClosure: (() -> Void)?
        
        override func reloadData() {
            reloadDataCalledClosure?()
        }
    }

}
