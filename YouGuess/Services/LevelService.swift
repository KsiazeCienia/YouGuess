//
//  LevelService.swift
//  YouGuess
//
//  Created by Marcin Włoczko on 15.05.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import Foundation

protocol LevelServiceDelegate: class {
    
    func levelService(levelService: LevelService, levelsDownloaded result: [Level])
    func levelService(levelService: LevelService, errorWithDownloading error: APIError)
}

final class LevelService {
    
    weak var delegate: LevelServiceDelegate?
    
    private let url = "level"
    
    func getLevelsList() {
        let endpoint = URLBuilder.fireBaseDataBase(withPath: url)
        APIClient.GETRequest(withURL: endpoint) { (response) in
            switch response {
            case .Error(error: let error) :
                DispatchQueue.main.async {
                    self.delegate?.levelService(levelService: self, errorWithDownloading: error)
                }
            case .Success(result: let data) :
                var levels = [Level]()
                let decoder = JSONDecoder()
                do {
                    levels = try decoder.decode([Level].self, from: data)
                    print(levels)
                }
                catch {
                    print(error.localizedDescription)
                }
                DispatchQueue.main.async {
                    self.delegate?.levelService(levelService: self, levelsDownloaded: levels)
                }
            }
        }
    }
}
