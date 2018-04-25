//
//  AdView.swift
//  YouGuess
//
//  Created by Marcin Włoczko on 26.07.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import UIKit
import GoogleMobileAds

final class AdView: UIView {
    
    //MARK:- Variables
    
    fileprivate var googleBanner:GADBannerView! = nil
    fileprivate weak var viewController: BaseViewController!
    private var bannerHeight: CGFloat { get { return 50 } }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        alpha = 0
    }
    
    //MARK:- Main
    
    func startDisplayingAdds() {
        configureAdMob()
    }
    
    func hookViewController(_ viewController: BaseViewController) {
        self.viewController = viewController
        configureAdMob()
    }
    
    func resize() {
        googleBanner.adSize = GADAdSizeFullWidthLandscapeWithHeight(bannerHeight)
    }
    
    private func configureAdMob() {
        debugPrint("FFAdView - Google Mobile Ads SDK version: \(GADRequest.sdkVersion())")
        googleBanner = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait, origin: CGPoint(x: 0, y: 0))
        let request = GADRequest()
        #if RELEASE
            if let id = UIApplication.plist().object(forKey: AdKeys.adMobBannerId.rawValue) as? String {
                googleBanner.adUnitID = id
            } else {
                Swift.debugPrint("FFAdView - Couldn't get adUnitID from plist, aborting")
                abort()
            }
        #else
            request.testDevices = [kGADSimulatorID]
            googleBanner.adUnitID = AdKeys.testAdId.rawValue
        #endif
        googleBanner.rootViewController = viewController
        googleBanner.delegate = self
        googleBanner.alpha = 0
        googleBanner.contentMode = .scaleToFill
        googleBanner.load(request)
        addSubview(googleBanner)
    }
    
}

//MARK:- GADBannerViewDelegate
extension AdView : GADBannerViewDelegate {
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        debugPrint("\(type(of: self)) - Google add recived succesfully")
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.alpha = 1
            bannerView.alpha = 1
        })
    }
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        log(message: "Did fail to receive ad with error \(error.localizedDescription)", event: .adMob)
    }
}

extension AdView: Loggable {}
