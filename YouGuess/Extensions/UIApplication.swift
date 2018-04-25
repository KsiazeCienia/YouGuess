//
//  dsfd.swift
//  YouGuess
//
//  Created by Marcin Włoczko on 27.07.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import UIKit

extension UIApplication {
    
    static func plist() -> NSDictionary {
        let path = Bundle.main.path(forResource: "Info", ofType: "plist")!
        let plist = NSDictionary(contentsOfFile: path)!
        return plist
    }
}
