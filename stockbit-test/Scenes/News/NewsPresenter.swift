//
//  NewsPresenter.swift
//  stockbit-test
//
//  Created by Iqbal Zauqul Adib on 26/12/21.
//

protocol NewsPresentationLogic {
    func presentNews(response: NewsModels.FetchNews.Response)
}

class NewsPresenter: NewsPresentationLogic {
    
    weak var viewController: NewsDisplayLogic?
    
    init(viewController: NewsDisplayLogic){
        self.viewController = viewController
    }
    
    func presentNews(response: NewsModels.FetchNews.Response) {
        let displayedNews = getDisplayedNews(news: response.news)
        let viewModel = NewsModels.FetchNews.ViewModel(displayedNews: displayedNews, error: response.error)
        self.viewController?.displayNews(viewModel: viewModel)
    }
    
    private func getDisplayedNews(news: [News]? ) -> [NewsModels.DisplayedNews]? {
        guard let news = news else {
            return nil
        }
        
        return news.map{ (newsItem) -> NewsModels.DisplayedNews in
            return NewsModels.DisplayedNews(title: newsItem.title, body: newsItem.body, source: newsItem.source)
        }
    }
    
}


