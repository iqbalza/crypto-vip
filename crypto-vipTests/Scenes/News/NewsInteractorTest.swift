//
//  NewsInteractorTest.swift
//  crypto-vipTests
//
//  Created by Iqbal Zauqul Adib on 26/12/21.
//

import XCTest
@testable import crypto_vip

class NewsInteractorTest: XCTestCase {

    var sut: NewsInteractor!
    
    func testFetchNews() {
        //given
        let presenterSpy = PresenterSpy()
        let newsServiceMock = NewsServiceMock()
        let stub = NewsSceneStub.NewsResponseStub.all
        newsServiceMock.result =  .success(stub)
        sut = NewsInteractor(newsService: newsServiceMock, presenter: presenterSpy)
        //when
        let request = NewsModels.FetchNews.Request(category: "BTC")
        sut.fetchNews(request: request)
        //then
        XCTAssertTrue(presenterSpy.isPresentNewsCalled)
        XCTAssert(presenterSpy.response!.error == nil)
        XCTAssertTrue(newsServiceMock.isFetchNewsCalled)
        XCTAssertEqual(presenterSpy.response!.news, stub.news)
    }
    
    
    
    class PresenterSpy: NewsPresentationLogic {
        
        var isPresentNewsCalled = false
        var response: NewsModels.FetchNews.Response?

        func presentNews(response: NewsModels.FetchNews.Response) {
            isPresentNewsCalled = true
            self.response = response
        }
    
    }
    
    class NewsServiceMock: NewsServiceProtocol {
        
        var result: Result<NewsResponse, APIErrorResult>?
        var isFetchNewsCalled = false
        
        func fetchNews(category: String, completion: @escaping (Result<NewsResponse, APIErrorResult>) -> ()) {
            completion(result!)
            isFetchNewsCalled = true
        }
    }
}
