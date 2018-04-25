//
//  Response.swift
//  YouGuess
//
//  Created by Marcin Włoczko on 15.05.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import Foundation

typealias ResultBlock<T> = (Result<T>) -> ()

enum Result<T> {
    case Error(error : APIError)
    case Success(result : T)
}

enum ArrayResult<T> {
    case Error(error : APIError)
    case Success(result : [T])
}

enum APIError: CustomStringConvertible, Error {
    case unexpectedError
    case noData
    case wrongHTTPCode(code: Int )
    case jsonSerializationFailed
    
     var description: String {
        switch self {
        case .unexpectedError:
            return NSLocalizedString("Brak połączenia internetowego", comment: "")
        case .noData:
            return NSLocalizedString("Brak poziomów - spróbuj później", comment: "")
        case .jsonSerializationFailed :
            return NSLocalizedString("Błąd aplikacji - spróbuj później", comment: "")
        case .wrongHTTPCode(code: let code):
            return NSLocalizedString("Bład numer: \(code)", comment: "")
        }
    }
}



