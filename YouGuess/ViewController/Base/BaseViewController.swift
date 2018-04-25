//
//  BaseViewController.swift
//  YouGuess
//
//  Created by Marcin Włoczko on 14.05.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController{
    
    //MARK:- Abstrac VC's don't use directly
    
    private(set) var delegate: MainNavigationControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundImage()
        setupNavitationBar()
        setupDeleagte()
    }

    private func setupDeleagte() {
        guard let navigationController = navigationController as? MainNavigationController else { return }
        delegate = navigationController
    }
    
    private func setBackgroundImage() {
        let background = UIImageView(image: #imageLiteral(resourceName: "background"))
        background.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(background, at: 0)
        let topConstraint = NSLayoutConstraint(item: background, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: background, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        let leftConstraint = NSLayoutConstraint(item: background, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
        let rightConstraint = NSLayoutConstraint(item: background, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        view.addConstraints([topConstraint, bottomConstraint, leftConstraint, rightConstraint])
    }
    
    private func setupNavitationBar() {
        self.navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "Wroc").withRenderingMode(.alwaysOriginal)
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "Wroc").withRenderingMode(.alwaysOriginal)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    deinit {
        debugPrint("deinit of \(type(of: self))")
    }
}
