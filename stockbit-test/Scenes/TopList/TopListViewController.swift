//
//  TopListViewController.swift
//  stockbit-test
//
//  Created by Iqbal Zauqul Adib on 25/12/21.
//

import UIKit

protocol TopListDisplayLogic {
    func displayTopLists(viewModel: TopListModels.FetchTopList.ViewModel)
}

class TopListViewController: UIViewController, TopListDisplayLogic {
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var refreshControl = UIRefreshControl()
    
    var interactor: TopListBusinessLogic?
    
    var displayedTopLists: [TopListModels.DisplayedTopList] = []

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
    }
    
    func displayTopLists(viewModel: TopListModels.FetchTopList.ViewModel) {
        indicator.stopAnimating()
        refreshControl.endRefreshing()
        
        guard let topLists = viewModel.displayedTopLists else {
            handleError(error: viewModel.error!)
            return
        }
        
        self.displayedTopLists = topLists
        tableView.reloadData()
    }
    
    func handleError(error: APIErrorResult){
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
    
}
