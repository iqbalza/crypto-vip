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

class TopListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
