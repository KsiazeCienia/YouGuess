//
//  String.swift
//  YouGuess
//
//  Created by Marcin Włoczko on 06.10.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import Foundation

extension String {
    func to2DCharactersArray(separetedBy separator: Character) -> [[Character]] {
        var twoDArray = [[Character]]()
        var tmp = [Character]()
        for character in self.characters {
            if (character == separator) {
                twoDArray.append(tmp)
                tmp.removeAll()
            } else {
                tmp.append(character)
            }
        }
        twoDArray.append(tmp)
        return twoDArray
    }
}
