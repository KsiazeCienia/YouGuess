//
//  LoginViewController.swift
//  YouGuess
//
//  Created by Marcin Włoczko on 11.10.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import UIKit
import FBSDKLoginKit

final class LoginViewController: UIViewController {
    
    //MARK:- IBOultets

    @IBOutlet fileprivate weak var loginButton: FBSDKLoginButton!
    
    //MARK:- VC's life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.delegate = self
    }
}

//MARK:- FBSDKLoginButtonDelegate
extension LoginViewController: FBSDKLoginButtonDelegate {
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        //MARK:- TODO pytanie czy zostawić puste ale chyba tak
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print("Błą∂ logowania")
            return
            //MARK:- komunikat o błędzie logowania
        }
        
        UserInfoManager.saveUserFacebookId(id: FBSDKAccessToken.current().userID)
        
        guard let menuVC = Storyboard.Main.instantiateInitialViewController() as? UINavigationController else {
            assert(false, "MenuView not found!")
            return
        }
        self.present(menuVC, animated: true, completion: nil)
    }
}
