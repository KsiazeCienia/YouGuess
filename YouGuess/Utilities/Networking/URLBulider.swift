//
//  URLBulider.swift
//  YouGuess
//
//  Created by Marcin Włoczko on 15.05.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import Foundation

final class URLBuilder {
    
    static func fireBaseStorage(withLevel level: Int, path: String) -> URL {
        let urlString = "https://firebasestorage.googleapis.com/v0/b/youguess-7c81e.appspot.com/o/Poziom\(String(level))%2F\(path).png?alt=media"
        return URL(string: urlString)!
    }
    
    static  func  fireBaseDataBase(withPath path: String) -> URL {
        let urlString = "https://youguess-7c81e.firebaseio.com/\(path).json"
        return URL(string: urlString)!
    }
}
