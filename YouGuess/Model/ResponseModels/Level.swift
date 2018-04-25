//
//  Level.swift
//  YouGuess
//
//  Created by Marcin Włoczko on 15.05.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import Foundation

struct Level: Codable {

    var youtubers: [YouTuber] 
    var price: Int
    var number: Int
    
    private enum CodingKeys: String, CodingKey {
        case price
        case number
        case youtubers = "youtuber"
    }
    
}

