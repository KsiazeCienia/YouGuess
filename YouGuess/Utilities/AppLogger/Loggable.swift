//
//  Loggable.swift
//  YouGuess
//
//  Created by Marcin Włoczko on 05.10.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import Foundation
import Crashlytics

protocol Loggable {
    
    func log(message: String, event: EventType)
}

extension Loggable {
    
    func log(message: String, event: EventType) {
        Answers.logCustomEvent(withName: message, customAttributes: ["Event Type": event])
    }
}

