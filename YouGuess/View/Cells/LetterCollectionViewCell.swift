//
//  LetterCollectionViewCell.swift
//  YouGuess
//
//  Created by Marcin on 16.05.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import UIKit

final class LetterCollectionViewCell: UICollectionViewCell {
    
    static let side: CGFloat = 35.0

    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
            clipsToBounds = true
            backgroundColor = .white
            layer.shadowOffset = CGSize(width: 1, height: 1)
            layer.shadowColor = UIColor.black.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height/2
        label.font = UIFont(name: AppDefaults.mainFont, size: frame.height * 0.71)
    }
    
    func setUpCell(letter: String) {
        label.text = letter.uppercased()
    }
}
