//
//  APIClient.swift
//  YouGuess
//
//  Created by Marcin Włoczko on 14.05.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import Foundation

final class APIClient: Networking {
    
    static func GETRequest(withURL url: URL, completion:  @escaping ResultBlock<Data>) {
        let (request, session) = configuration(forURL: url, httpMethod: HTTPMethods.GET.rawValue)
        session.dataTask(with: request) { (data, response, error) in
            if let _ = error {
                completion(Result.Error(error: APIError.unexpectedError))
                return
            }
            guard let data = data, let httpResponse = response as? HTTPURLResponse else {
                completion(Result.Error(error: APIError.noData))
                return
            }
            guard httpResponse.statusCode == 200 || httpResponse.statusCode == 201 else {
                completion(Result.Error(error: APIError.wrongHTTPCode(code: httpResponse.statusCode)))
                return
            }
            completion(Result.Success(result: data))
            }.resume()
    }
    
    
    static  func configuration(forURL url: URL, httpMethod: String) -> (request: URLRequest, session: URLSession) {
        let sessionConfiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfiguration)
        let request = URLRequest(url: url)
        return (request, session)
    }
}
