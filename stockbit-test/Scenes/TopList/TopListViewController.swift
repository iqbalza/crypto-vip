//
//  TopListViewController.swift
//  stockbit-test
//
//  Created by Iqbal Zauqul Adib on 25/12/21.
//

import UIKit

protocol TopListDisplayLogic {
    func successFetchedTopList(viewModel: [TopListModels.FetchTopList.ViewModel.TopList])
    func errorFetchinTopList(viewModel:TopListModels.FetchTopList.ViewModel)
}

class TopListViewController: UIViewController, TopListDisplayLogic {
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var refreshControl = UIRefreshControl()
    
    var interactor: TopListBusinessLogic?
    
    var topListsViewModel: [TopListModels.FetchTopList.ViewModel.TopList] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchTopList()
    }
    
    
    func setup() {
        let viewController = self
        let presenter = TopListPresenter()
        let interactor = TopListInteractor(service: TopListService.shared)
        interactor.presenter = presenter
        viewController.interactor = interactor
        presenter.viewController = viewController
    }
    
    func setupUI() {
        title = "TopLists"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: "TopListTableViewCell", bundle: nil), forCellReuseIdentifier: TopListTableViewCell.identifier)
        
        refreshControl.addTarget(self, action: #selector(fetchTopList), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
   @objc func fetchTopList() {
        interactor?.fetchTopList(request: TopListModels.FetchTopList.Request())
        //loading
    }
    
    func successFetchedTopList(viewModel: [TopListModels.FetchTopList.ViewModel.TopList]) {
        indicator.stopAnimating()
        refreshControl.endRefreshing()
        topListsViewModel = viewModel
        tableView.reloadData()
    }
    
    func errorFetchinTopList(viewModel: TopListModels.FetchTopList.ViewModel) {
        indicator.stopAnimating()
        refreshControl.endRefreshing()
    }

}
extension TopListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        topListsViewModel.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: TopListTableViewCell.identifier)  as! TopListTableViewCell
        cell.configure(viewModel: topListsViewModel[indexPath.row])
        return cell
    }
    
    
    
    
}
