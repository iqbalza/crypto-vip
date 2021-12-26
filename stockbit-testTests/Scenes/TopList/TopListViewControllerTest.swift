//
//  TopListViewTest.swift
//  stockbit-testTests
//
//  Created by Iqbal Zauqul Adib on 26/12/21.
//

import XCTest
@testable import stockbit_test

class TopListViewControllerTest: XCTestCase {
    
    var sut: TopListViewController!
    var interactorSpy: InteractorSpy!
    
    override func setUp() {
        super.setUp()
        interactorSpy = InteractorSpy()
        sut = TopListViewController(interactor: interactorSpy)
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        interactorSpy = nil
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
        let tableViewSpyClosure: (()-> Void) = {
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
