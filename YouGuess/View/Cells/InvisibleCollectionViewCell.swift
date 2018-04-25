//
//  InvisibleCollectionViewCell.swift
//  YouGuess
//
//  Created by Marcin on 16.05.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import UIKit

class InvisibleCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        clipsToBounds = true
        layer.cornerRadius = frame.height/2
    }

}
