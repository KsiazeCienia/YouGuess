//
//  AboutViewController.swift
//  YouGuess
//
//  Created by Marcin Włoczko on 15.07.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import UIKit

final class AboutViewController: UIViewController {
    
    //MARK:- IBOutlets

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet private weak var dismissButton: UIButton!
    @IBOutlet private  weak var versionLabel: UILabel!
    
    //MARK: VC's Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK:- Main
    
    private func setupView() {
        dismissButton.setImage(#imageLiteral(resourceName: "navbar_cross").withRenderingMode(.alwaysTemplate), for: .normal)
        dismissButton.tintColor = UIColor.navaigationColor()
        setUpAboutUs()
        versionLabel.text = "Version: \(appVersion())"
    }
    
    private func setUpAboutUs() {
        infoLabel.text = "Made by Pistacio for Skylarks"
    }
    
    private func appVersion() -> String {
        guard let shortVerison = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") else { return "N/A" }
        guard let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") else { return "N/A" }
        return "\(shortVerison) (\(version))"
    }
    
    //MARK:- IBAction
    
    @IBAction private func dismissButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}
