//
//  LocalStoreManager.swift
//  YouGuess
//
//  Created by Marcin Włoczko on 28.05.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import Foundation

final class LocalStoreManager {
    
    static func saveUserScore(withData arryOfNames:  [String], level: Int) {
        UserDefaults.standard.set(arryOfNames, forKey: UserDefaultsKeys.UserScore.rawValue + String(level))
    }
    
    static func getUserScore(withLevel level: Int) -> [String]? {
        return  UserDefaults.standard.value(forKey: UserDefaultsKeys.UserScore.rawValue + String(level)) as? [String]
    }
    
    static func saveUserPoints(points: Int) {
        UserDefaults.standard.set(points, forKey: UserDefaultsKeys.UserPoints.rawValue)
    }
    
    static func getUserPoints() -> Int? {
        return UserDefaults.standard.value(forKey: UserDefaultsKeys.UserPoints.rawValue) as? Int
    }
    
    static func getUnlockedLevels() -> [Int]? {
        return UserDefaults.standard.value(forKey: UserDefaultsKeys.UnlockedLevels.rawValue) as? [Int]
    }
    
    static func saveUnlockedLevels(levels: [Int]) {
        UserDefaults.standard.set(levels, forKey: UserDefaultsKeys.UnlockedLevels.rawValue)
    }
    
    static func saveFacebookId(id: String) {
        UserDefaults.standard.set(id, forKey: UserDefaultsKeys.UserFacebookId.rawValue)
    }
    
    static func getFacebookId() -> String? {
        return UserDefaults.standard.value(forKey: UserDefaultsKeys.UserFacebookId.rawValue) as? String
    }
    
    static func removeAllData() {
        guard let appDomain = Bundle.main.bundleIdentifier else { return }
        UserDefaults.standard.removePersistentDomain(forName: appDomain)
    }
}
