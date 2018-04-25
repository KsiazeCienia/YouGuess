//
//  ImageDownloader.swift
//  YouGuess
//
//  Created by Marcin Włoczko on 15.05.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import UIKit
import Haneke

typealias ImageDownloaded = (_ image: UIImage?, _ success: Bool) -> Void

final class ImageProvider {
    
    static func getImage(_ url: URL, completion: @escaping ImageDownloaded) {
        let cache = Shared.imageCache
        let fetcher = NetworkFetcher<UIImage>(URL: url)
        cache.fetch(fetcher: fetcher).onSuccess { image in
            completion(image, true)
            }.onFailure { (error) in
                completion(nil, false)
        }
    }
}
