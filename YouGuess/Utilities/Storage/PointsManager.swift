//
//  PointsManager.swift
//  YouGuess
//
//  Created by Marcin on 25.06.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import Foundation

struct PointsManager {
    
    static func addUserPoints(points: Int) {
        if var actualUserPoints = LocalStoreManager.getUserPoints() {
            actualUserPoints += points
            LocalStoreManager.saveUserPoints(points: actualUserPoints)
        } else {
            LocalStoreManager.saveUserPoints(points: points)
        }
    }
    
    static func getUserPoints() -> Int {
        return  LocalStoreManager.getUserPoints() ?? 0
    }
    
    static func removeUserPoints(points: Int) {
        if var actualUserPoints = LocalStoreManager.getUserPoints() {
            actualUserPoints -= points
            LocalStoreManager.saveUserPoints(points: actualUserPoints)
        }
    }
    
    static func hasUserEnoughPoints(points: Int) -> Bool {
        if let actualUserPoints = LocalStoreManager.getUserPoints() {
            return actualUserPoints >= points
        } else {
            return false
        }
    }
}
