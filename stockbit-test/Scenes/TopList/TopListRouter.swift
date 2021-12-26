//
//  TopListRouter.swift
//  stockbit-test
//
//  Created by Iqbal Zauqul Adib on 25/12/21.
//

import UIKit


protocol TopListRoutingLogic {
    func routeToNews(category: String)
}

class TopListRouter: TopListRoutingLogic {
    
    weak var viewController: TopListViewController?
    
    init(viewController: TopListViewController) {
        self.viewController = viewController
    }
    
    func routeToNews(category: String) {
        let newsViewController = NewsViewController(category: category)
        let navigationControlelr = UINavigationController(rootViewController: newsViewController)
        viewController?.present(navigationControlelr, animated: true, completion: nil)
    }
}
