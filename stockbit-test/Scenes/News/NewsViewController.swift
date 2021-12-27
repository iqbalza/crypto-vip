//
//  NewsViewController.swift
//  stockbit-test
//
//  Created by Iqbal Zauqul Adib on 26/12/21.
//

import UIKit

protocol NewsDisplayLogic: AnyObject {
    func displayNews(viewModel: NewsModels.FetchNews.ViewModel)
}

class NewsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var interactor: NewsBusinessLogic?
    var displayedNews: [NewsModels.DisplayedNews] = []
    var category: String?
    var websocket: LiveUpdateService!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil:
      Bundle?) {
        super.init(nibName: nibNameOrNil, bundle:nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    //for unit test
    init(interactor: NewsBusinessLogic? = nil, category: String) {
        super.init(nibName: nil, bundle: nil)
        self.category = category
        self.interactor = interactor
    }
    
    init(category: String) {
        super.init(nibName: nil, bundle: nil)
        self.category = category
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchNews()
        

    }
    deinit {
        print("view dc")
    }
    
    func setup() {
        let viewController = self
        let presenter = NewsPresenter(viewController: viewController)
        interactor = NewsInteractor(presenter: presenter)
    }
    
    func setupUI() {
        title = "News"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: NewsTableViewCell.identifier)
    }
    
    func fetchNews() {
        interactor?.fetchNews(request: NewsModels.FetchNews.Request(category: category!))
    }

}

extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier)  as! NewsTableViewCell
        cell.configure(displayedNews:self.displayedNews[indexPath.row])
        return cell
    }
}

extension NewsViewController: NewsDisplayLogic {
    func displayNews(viewModel: NewsModels.FetchNews.ViewModel) {
        DispatchQueue.main.async {
            guard let displayedNews = viewModel.displayedNews else {
                //handleError
                return
            }
            self.displayedNews = displayedNews
            self.tableView.reloadData()
        }
        
    }
    
    
}
