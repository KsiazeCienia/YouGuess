//
//  LevelsManager.swift
//  YouGuess
//
//  Created by Marcin on 14.07.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import Foundation

final class LevelsManager {
    
    static func addUnlockedLevel(level: Int) {
        if var unlockedLevels = LocalStoreManager.getUnlockedLevels() {
            unlockedLevels.append(level)
            LocalStoreManager.saveUnlockedLevels(levels: unlockedLevels)
        } else {
            LocalStoreManager.saveUnlockedLevels(levels: [0, level])
        }
    }
    
    static func contains(level: Int) -> Bool {
        let levels = LevelsManager.getUnlockedLevels()
        return levels.contains(level)
    }

    static func getUnlockedLevels() -> [Int] {
        if let unlockedLevels = LocalStoreManager.getUnlockedLevels() {
            return unlockedLevels
        } else {
            return [0]
        }
    }
}
