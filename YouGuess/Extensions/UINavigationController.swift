//
//  UINavigationController.swift
//  YouGuess
//
//  Created by Marcin Włoczko on 07.10.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    func replaceCurrentViewControllerWith(viewController: UIViewController, animated: Bool) {
        var controllers = viewControllers
        controllers.removeLast()
        controllers.append(viewController)
        setViewControllers(controllers, animated: animated)
    }
}
