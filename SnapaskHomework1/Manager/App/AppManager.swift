//
//  AppManager.swift
//  SnapaskHomework
//
//  Created by Albert_Chien on 2021/6/24.
//

import UIKit

class AppManager {
    
    private let keyChain:KeyChainable
    
    private var isAuthed:Bool {
        keyChain.accessToken != nil
    }
    
    static let shared = AppManager()
    
    init(keyChain:KeyChainable = KeyChainManager()){
        self.keyChain = keyChain
    }
    
    func start(in window: UIWindow?) {
        let vc = getCurrentRootViewController()
        let navi = UINavigationController(rootViewController: vc)
        window?.rootViewController = navi
        window?.makeKeyAndVisible()
    }

    func getCurrentRootViewController()->UIViewController {
        let loginAuthViewController = LoginAuthViewController()
        let userListViewController = UserListViewController()
        let navi = isAuthed ? userListViewController : loginAuthViewController
        return navi
    }
}
