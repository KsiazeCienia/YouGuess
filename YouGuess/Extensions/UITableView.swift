//
//  UITableView.swift
//  YouGuess
//
//  Created by Marcin Włoczko on 14.10.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import UIKit

extension UITableView {
    
    func register<T: UITableViewCell>(_: T.Type) {
        register(UINib(nibName: T.identifier, bundle: nil), forCellReuseIdentifier: T.identifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.identifier)")
        }
        return cell
    }
}

