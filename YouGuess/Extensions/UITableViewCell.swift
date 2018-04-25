//
//  UITableViewCell+Identifier.swift
//  YouGuess
//
//  Created by Marcin on 14.05.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import UIKit

extension UITableViewCell {
    public static var identifier: String {
        return String(describing: self)
    }
}
