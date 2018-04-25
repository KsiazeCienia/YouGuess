//
//  Array.swift
//  YouGuess
//
//  Created by Marcin Włoczko on 06.10.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import UIKit

extension Array where Element: Collection, Element.Index == Int, Element.IndexDistance == Int {
    func numberOfElements() -> Int {
        var i = 0
        for innerArray in self {
            for _ in innerArray {
                i += 1
            }
        }
        return i
    }
}

extension Array {
    mutating func randomize() {
        for _ in 0 ..< QuizKeys.numberOfIterationInMixing {
            let randIndex = Int(arc4random_uniform(UInt32(self.count)))
            let randIndex2 = Int(arc4random_uniform(UInt32(self.count)))
            let tmp = self[randIndex]
            self[randIndex] = self[randIndex2]
            self[randIndex2] = tmp
        }
    }
}


