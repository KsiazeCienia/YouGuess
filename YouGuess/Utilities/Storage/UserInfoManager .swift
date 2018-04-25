//
//  UserInfoManager .swift
//  YouGuess
//
//  Created by Marcin Włoczko on 14.10.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import Foundation

final class UserInfoManager {
    
    static func isUserLogIn() -> Bool {
        if let _ = LocalStoreManager.getFacebookId() {
            return true
        }
        return false
    }
    
    static func saveUserFacebookId(id: String) {
        LocalStoreManager.saveFacebookId(id: id)
    }
    
    static func getUserFacebookId(id: String) -> String {
        return LocalStoreManager.getFacebookId()!
    }
}
