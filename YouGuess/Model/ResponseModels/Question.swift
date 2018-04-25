//
//  Question.swift
//  YouGuess
//
//  Created by Marcin on 25.05.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import UIKit

final class Question: NSObject {

    var level: Int
    var image: UIImage
    var name: String
    var path: String
    var isDone: Bool {
        get {
            return ScoreManager.isUserCompleteChallenge(withLevel: level, challengeName: name)
        }
    }
    
    init(name: String, image: UIImage, level: Int, path: String) {
        self.name = name
        self.image = image
        self.level = level
        self.path = path
    }
}
