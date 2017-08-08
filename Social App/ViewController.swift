//
//  ViewController.swift
//  Social App
//
//  Created by Stefan Markovic on 8/8/17.
//  Copyright © 2017 Stefan Markovic. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func fbButton(_ sender: UIButton) {
        
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("Cannot login with facebook")
            } else if result?.isCancelled == true {
                print("Canceled")
            } else {
                print("Success with facebook")
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        }

    }
    
    func firebaseAuth(_ credential: AuthCredential){
        Auth.auth().signIn(with: credential) { (user, error) in
            if error != nil {
                print("Unable to auth with firebase")
            } else {
                print("Success with firebase")
            }
        }
        
    }
  




}

