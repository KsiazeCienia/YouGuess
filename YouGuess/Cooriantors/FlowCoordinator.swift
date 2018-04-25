//
//  MainCoordinator .swift
//  YouGuess
//
//  Created by Marcin Włoczko on 11.10.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import UIKit
import FBSDKLoginKit

final class FlowCoordinator {
    
    private var navigationController: UINavigationController
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.navigationController = UINavigationController()
        self.window = window
    }
    
    func start() {
        setupApplicationView()
    }
    
    private func setupApplicationView() {
      //  if UserInfoManager.isUserLogIn() {
            setupApplicationMainView()
        //} else {
          //  setupLoginView()
        //}
    }
    
    private func setupApplicationMainView() {
        guard let menuVC = Storyboard.Main.instantiateInitialViewController() as? UINavigationController else {
            assert(false, "MenuView not found!")
            return
        }
        navigationController = menuVC
        window.rootViewController = menuVC
    }
    
    private func setupLoginView() {
        let loginVC = Storyboard.LoginRegister.instantiateViewController(withIdentifier: LoginViewController.identifier)
        window.rootViewController = loginVC
    }
}
