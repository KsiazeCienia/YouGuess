//
//  MainNavigationController.swift
//  YouGuess
//
//  Created by Marcin on 22.06.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import UIKit

protocol MainNavigationControllerDelegate: class {
    
    func refreshPointsStatus()
}

final class MainNavigationController: UINavigationController {
    
    private var userPointsLabel =  UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupNavigationBarItems()
        
    }
    
    private func setupNavigationBar() {
        self.navigationBar.isTranslucent = false
        self.navigationBar.barTintColor = UIColor.navaigationColor()
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
    }
    
    
    private func setupNavigationBarItems() {
        userPointsLabel.frame = CGRect(x: view.frame.width - 75, y: 5, width: 34, height: 34)
        userPointsLabel.text = String(PointsManager.getUserPoints())
        userPointsLabel.font = UIFont(name: AppDefaults.mainFont, size: 20)
        userPointsLabel.textAlignment = .right
        userPointsLabel.textColor = .white
        self.navigationBar.addSubview(userPointsLabel)
        
        let imageView = UIImageView(frame: CGRect(x: view.frame.width - 41, y: 8, width: 24, height: 24))
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "Dzwoneczek").withRenderingMode(.alwaysOriginal)
        self.navigationBar.addSubview(imageView)
    }
}

//MARK:- MainNavigationControllerDelegate
extension MainNavigationController: MainNavigationControllerDelegate {
    
    func refreshPointsStatus() {
        userPointsLabel.text = PointsManager.getUserPoints().description
    }
}
