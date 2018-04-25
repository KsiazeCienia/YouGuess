//
//  ScoreManager.swift
//  YouGuess
//
//  Created by Marcin Włoczko on 29.05.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import Foundation

final class ScoreManager {
    
     static func addUserScore(withLevel level : Int, challengeName: String) {
        if var challengeNames = LocalStoreManager.getUserScore(withLevel: level) {
            challengeNames.append(challengeName)
            LocalStoreManager.saveUserScore(withData: challengeNames, level: level)
        }else {
            LocalStoreManager.saveUserScore(withData: [challengeName], level: level)
        }
    }
    
    static func isUserCompleteChallenge(withLevel level: Int, challengeName: String) -> Bool {
        guard let challengeNames = LocalStoreManager.getUserScore(withLevel: level) else { return false }
        return challengeNames.contains(challengeName)
    }
    
    static func getNumberOfResolvedQuestions(inLevel level: Int) -> Int {
        guard let count = LocalStoreManager.getUserScore(withLevel: level)?.count else { return 0 }
        return count
    }
}
