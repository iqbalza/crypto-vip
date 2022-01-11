//
//  SceneDelegate.swift
//  crypto-vip
//
//  Created by Iqbal Zauqul Adib on 24/12/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        
        let nc = UINavigationController(rootViewController: TopListViewController())
        
        self.window?.rootViewController = nc
        window?.makeKeyAndVisible()
    }

    


}

