//
//  MenuViewController.swift
//  YouGuess
//
//  Created by Marcin on 14.05.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import UIKit

final class MenuViewController:  BaseViewController {

    //MARK:- IBOutlets
    
    @IBOutlet private weak var adView: AdView!
    @IBOutlet weak var playButton: PlayButton!
    
    //MARK:- References
    
    private let levelService = LevelService()
    private var adManager: GoogleFullscreenAdManager!
    
    //MARK:- Variables
    
    fileprivate var levels: [Level] = []
    
    //MARK:- VC's Life cycle
    
    override func viewDidLoad() {
        setupLevelService()
        setupNavigationBar()
        super.viewDidLoad()
        adManager = GoogleFullscreenAdManager(withController: self)
        setupAdView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        delegate?.refreshPointsStatus()
    }
    
    //MARK:- Main
    
    private func setupAdView() {
        adView.hookViewController(self)
    }

    private func setupLevelService() {
        levelService.delegate = self
    }
    
    private func getLevels() {
        playButton.isEnabled = false
        levelService.getLevelsList()
    }
    
 
    
    private func showLevlesView() {
        guard let levelsVC = Storyboard.Main.instantiateViewController(withIdentifier: LevelsViewController.identifier) as? LevelsViewController else { return }
        levelsVC.levelsList = levels
        navigationController?.pushViewController(levelsVC, animated: true)
    }
    
    private func setupNavigationBar() {
        let infoButton = UIButton(type: .custom)
        infoButton.setImage(#imageLiteral(resourceName: "Info"), for: .normal)
        infoButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        infoButton.addTarget(self, action: #selector(showAboutView), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: infoButton)
        navigationItem.setLeftBarButtonItems([item1], animated: true)
    }
    
    @objc private func showAboutView() {
        let aboutViewController = Storyboard.Info.instantiateViewController(withIdentifier: AboutViewController.identifier)
        aboutViewController.modalTransitionStyle = .crossDissolve
        present(aboutViewController, animated: true, completion: nil)
    }
    
    //MARK:- IBActions
    
    @IBAction private func playButtonTapped(_ sender: Any) {
        log(message: "User tapped play button", event: .log)
        getLevels()
    }
    
    @IBAction private func showAdViewTapped() {
        adManager.reload()
    }
}

//MARK:- LevelServiceDelegate
extension MenuViewController: LevelServiceDelegate {
    
    func levelService(levelService: LevelService, levelsDownloaded result: [Level]) {
        levels = result
        playButton.isEnabled = true
        showLevlesView()
        log(message: "User downloaded levels button", event: .log)
    }
    
    func levelService(levelService: LevelService, errorWithDownloading error: APIError) {
        UIAlertController.show(error: error)
        playButton.isEnabled = true
        log(message: "User failed to download levels with error \(error.localizedDescription)", event: .error)
    }
}

//MARK:- Loggable
extension MenuViewController: Loggable { }
