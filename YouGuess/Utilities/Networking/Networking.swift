//
//  Networking.swift
//  YouGuess
//
//  Created by Marcin Włoczko on 15.05.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import Foundation

protocol Networking {
    
    static func GETRequest(withURL url: URL, completion: @escaping ResultBlock<Data>)
    static  func configuration(forURL url: URL, httpMethod: String) -> (request: URLRequest, session: URLSession) 
}
