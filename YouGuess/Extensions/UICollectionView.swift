//
//  UICollectionView.swift
//  YouGuess
//
//  Created by Marcin Włoczko on 14.10.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func register<T: UICollectionViewCell>(_: T.Type) {
        register(UINib(nibName: T.identifier, bundle: nil), forCellWithReuseIdentifier: T.identifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.identifier)")
        }
        return cell
    }
}

