//
//  NewsPresenterTest.swift
//  crypto-vipTests
//
//  Created by Iqbal Zauqul Adib on 26/12/21.
//

import XCTest
@testable import crypto_vip

class NewsPresenterTest: XCTestCase {

    var sut: NewsPresenter!
    
    func testPresentNews() {
        //given
        let viewControllerSpy = NewsViewControllerSpy()
        let expectedDisplayedNews = NewsSceneStub.DisplayedNews.all
        sut = NewsPresenter(viewController: viewControllerSpy)
        
        
        //when
        let stubNews = NewsSceneStub.NewsResponseStub.all.news
        let response = NewsModels.FetchNews.Response(news: stubNews, error: nil)
        sut.presentNews(response: response)
        
        //then
        XCTAssertTrue(viewControllerSpy.isDisplayNewsCalled)
        XCTAssertEqual(viewControllerSpy.viewModel.displayedNews,expectedDisplayedNews)
    }
    
    class NewsViewControllerSpy: NewsDisplayLogic {
        
        var isDisplayNewsCalled = false
        var viewModel: NewsModels.FetchNews.ViewModel!
        
        func displayNews(viewModel: NewsModels.FetchNews.ViewModel) {
            isDisplayNewsCalled = true
            self.viewModel = viewModel
        }
        
    }

}
