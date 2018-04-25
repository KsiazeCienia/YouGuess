//
//  GoogleFullscreenAdManager.swift
//  YouGuess
//
//  Created by Marcin Włoczko on 26.07.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import UIKit
import GoogleMobileAds

final class GoogleFullscreenAdManager: NSObject{
    
    //MARK:- Variables
    
    private weak var viewController: MenuViewController?
    fileprivate var canShow = false
    
    fileprivate var adMobWaiting = false
    private var interstitialAd : GADInterstitial!
    
    //MARK:- Main
    
     init(withController controller: MenuViewController) {
        self.viewController = controller
    }
    
    func reload() {
        guard  adMobWaiting == false else { return }
        let request = GADRequest()
        #if RELEASE
            guard let id = UIApplication.plist().object(forKey: AdKeys.adMobVideoId.rawValue) as? String else {
                debugPrint("FFFullscreenAdManager - Couldn't get adUnitID from plist, aborting")
                abort()
            }
            self.interstitialAd = GADInterstitial(adUnitID: id)
        #else
            self.interstitialAd = GADInterstitial(adUnitID: AdKeys.testAdId.rawValue)
            request.testDevices = [kGADSimulatorID]
        #endif
        self.interstitialAd.delegate = self
        self.interstitialAd.load(request)
    }
    
    fileprivate func show() {
        guard interstitialAd.isReady else { return }
        guard let viewController = viewController else { return }
        interstitialAd.present(fromRootViewController: viewController)
        PointsManager.addUserPoints(points: 2)
    }
}

//MARK:- GADInterstitialDelegate
extension GoogleFullscreenAdManager: GADInterstitialDelegate {
    
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        debugPrint("\(type(of: self)) - Google add recived succesfully")
        show()
    }
    
    func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
        UIAlertController.showAlert(withMessage: "Brak dostępnych reklam", message: "proszę, spróbuj później")
        log(message: "Did fail to receive ad with error \(error.localizedDescription)", event: .adMob)
        debugPrint("\(type(of: self)) - Google add downloading failed")
    }
}

//MARK:- Loggable
extension GoogleFullscreenAdManager: Loggable { }
