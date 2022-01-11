//
//  NewsViewControllerTest.swift
//  crypto-vipTests
//
//  Created by Iqbal Zauqul Adib on 26/12/21.
//

import XCTest
@testable import crypto_vip
class NewsViewControllerTest: XCTestCase {

    var sut: NewsViewController!
    var interactorSpy: InteractorSpy!
    var tableViewSpy: TableViewSpy!
    
    override func setUp() {
        interactorSpy = InteractorSpy()
        tableViewSpy = TableViewSpy()
        sut = NewsViewController(interactor: interactorSpy, category: "BTC")
        sut.loadViewIfNeeded()
    }
    override func tearDown() {
        interactorSpy = nil
        sut = nil
        tableViewSpy = nil
    }
    
    func testFetchNewsShouldBeCalledWhenViewDidLoad() {
        //when
        sut.viewDidLoad()
        
        //then
        XCTAssertTrue(interactorSpy.isFetchNewsCalled)
    }
    
    func testShouldDisplayNews() {
        //given
        let tableViewSpy = TableViewSpy()
        sut.tableView = tableViewSpy
        let displayedNews: [NewsModels.DisplayedNews] = []
        let viewModel = NewsModels.FetchNews.ViewModel(displayedNews: displayedNews, error: nil)
        let tableViewShouldReloadExp = XCTestExpectation(description: "view should reload tableview")
        let tableViewSpyClosure: (()-> Void) = {
            tableViewShouldReloadExp.fulfill()
        }
        tableViewSpy.reloadDataCalledClosure = tableViewSpyClosure
        
        //when
        sut.displayNews(viewModel: viewModel)
        
        //then
        wait(for: [tableViewShouldReloadExp], timeout: 5)
    }
    
    class InteractorSpy: NewsBusinessLogic {
        var isFetchNewsCalled = false
        
        func fetchNews(request: NewsModels.FetchNews.Request) {
            isFetchNewsCalled = true
        }

    }
    
    class TableViewSpy: UITableView {
        var reloadDataCalledClosure: (() -> Void)?
        
        override func reloadData() {
            reloadDataCalledClosure?()
        }
    }
    

}
