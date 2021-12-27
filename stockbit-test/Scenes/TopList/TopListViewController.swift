//
//  TopListViewController.swift
//  stockbit-test
//
//  Created by Iqbal Zauqul Adib on 25/12/21.
//

import UIKit

protocol TopListDisplayLogic: AnyObject {
    func displayTopLists(viewModel: TopListModels.FetchTopList.ViewModel)
    func displayPriceChangeUpdate(viewModel:TopListModels.SubscribePriceChange.ViewModel)
}

class TopListViewController: UIViewController {
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    var refreshControl = UIRefreshControl()
    var interactor: TopListBusinessLogic?
    var router: TopListRouter?
    var displayedTopLists: [TopListModels.DisplayedTopList] = []
    
    // MARK: - Initializers
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil:
      Bundle?) {
        super.init(nibName: nibNameOrNil, bundle:nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    init(interactor: TopListBusinessLogic? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.interactor = interactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchTopList()
    }
    
    private func setup() {
        let viewController = self
        let presenter = TopListPresenter(viewController: viewController)
        let router = TopListRouter(viewController: viewController)
        self.router = router
        interactor = TopListInteractor(presenter: presenter)
    }
    
    private func setupUI() {
        title = "TopLists"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: "TopListTableViewCell", bundle: nil), forCellReuseIdentifier: TopListTableViewCell.identifier)
        refreshControl.addTarget(self, action: #selector(fetchTopList), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc private func fetchTopList() {
        interactor?.fetchTopList(request: TopListModels.FetchTopList.Request())
    }
    
    private func handleError(error: APIErrorResult){
        let alert = UIAlertController(title: "Something went wrong", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { _ in
            self.fetchTopList()
        }))
        present(alert, animated: true, completion: nil)
    }
}

extension TopListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        displayedTopLists.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TopListTableViewCell.identifier)  as! TopListTableViewCell
        cell.configure(displayedTopList: displayedTopLists[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = displayedTopLists[indexPath.row].name
        router?.routeToNews(category: category)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}

extension TopListViewController: TopListDisplayLogic {
    
    func displayPriceChangeUpdate(viewModel: TopListModels.SubscribePriceChange.ViewModel ) {
        let indexPath = IndexPath(item: viewModel.index, section: 0)
        displayedTopLists[viewModel.index] = viewModel.displayedTopList
        DispatchQueue.main.async { [weak self] in
            UIView.performWithoutAnimation {
                self?.tableView.reconfigureRows(at: [indexPath])
            }
        }
    }
    
    func displayTopLists(viewModel: TopListModels.FetchTopList.ViewModel) {
        DispatchQueue.main.async {
            self.indicator.stopAnimating()
            self.refreshControl.endRefreshing()
            guard let topLists = viewModel.displayedTopLists else {
                self.handleError(error: viewModel.error!)
                return
            }
            self.displayedTopLists = topLists
            self.tableView.reloadData()
        }
    }
}
