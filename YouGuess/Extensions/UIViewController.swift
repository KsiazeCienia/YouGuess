//
//  UIViewController.swift
//  YouGuess
//
//  Created by Marcin Włoczko on 15.07.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import UIKit

extension UIViewController {
    public static var identifier: String {
        return String(describing: self)
    }
}
