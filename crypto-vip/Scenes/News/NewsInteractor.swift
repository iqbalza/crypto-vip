//
//  NewsInteractor.swift
//  crypto-vip
//
//  Created by Iqbal Zauqul Adib on 26/12/21.
//

protocol NewsBusinessLogic {
    func fetchNews(request: NewsModels.FetchNews.Request)
}

class NewsInteractor: NewsBusinessLogic {
    
    var newsService: NewsServiceProtocol
    var presenter: NewsPresentationLogic
    
    init(newsService: NewsServiceProtocol = NewsService.shared, presenter: NewsPresentationLogic) {
        self.newsService = newsService
        self.presenter = presenter
    }
    
    func fetchNews(request: NewsModels.FetchNews.Request) {
        var response: NewsModels.FetchNews.Response?
        newsService.fetchNews(category: request.category) { [weak self] result in
            switch result {
            case .success(let newsResponse):
                response = NewsModels.FetchNews.Response(news: newsResponse.news, error: nil)
            case .failure(let error):
                response = NewsModels.FetchNews.Response(news: nil, error: error)
            }
            self?.presenter.presentNews(response:response!)
        }
    }
}
