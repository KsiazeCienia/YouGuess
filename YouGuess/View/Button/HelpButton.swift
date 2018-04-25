//
//  HelpButton.swift
//  YouGuess
//
//  Created by Marcin Włoczko on 18.07.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import UIKit

final class HelpButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        imageView?.contentMode = .scaleAspectFit
    }

}
