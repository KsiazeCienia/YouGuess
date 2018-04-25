//
//  PlayButton.swift
//  YouGuess
//
//  Created by Marcin Włoczko on 16.05.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import UIKit

final class PlayButton: UIButton {
    
    private var activityIndicator: UIActivityIndicatorView!
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.05, animations: {
                self.layer.transform = CATransform3DMakeScale(self.isHighlighted ? 0.85 : 1, self.isHighlighted ? 0.85 : 1, 1)
                self.setNeedsLayout()
            })
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                activityIndicator.stopAnimating()
                tintColor = .white
            }else {
                activityIndicator.startAnimating()
                tintColor = .gray
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        tintColor = UIColor._darkRedColor()
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
        activityIndicator.color = .red
        addSubview(self.activityIndicator)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        activityIndicator.frame = CGRect(x: frame.width/2-25, y: frame.height/2-25, width: 50, height: 50)
    }
}
