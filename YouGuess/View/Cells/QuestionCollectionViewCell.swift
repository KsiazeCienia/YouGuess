//
//  QuestionCollectionViewCell.swift
//  YouGuess
//
//  Created by Marcin on 16.05.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import UIKit

final class QuestionCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var questionImage: UIImageView!
    @IBOutlet weak var tickImage: UIImageView!
    
    func setupCell(withQuestion question: Question) {
        questionImage.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleBottomMargin, .flexibleRightMargin, .flexibleLeftMargin, .flexibleTopMargin]
        questionImage.contentMode = .scaleAspectFill
        questionImage.clipsToBounds = true
        questionImage.alpha = question.isDone ? 1 : 0.3
        tickImage.alpha = question.isDone ? 1 : 0
        questionImage.image = question.image
        questionImage.layer.borderWidth = 3
        questionImage.layer.borderColor = UIColor.black.cgColor
        self.backgroundColor = UIColor.clear
    }
}
