//
//  UIView.swift
//  YouGuess
//
//  Created by Marcin Włoczko on 07.10.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import UIKit

extension UIView {
    
    func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - self.frame.width/50,y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + self.frame.width/50,y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }
}

