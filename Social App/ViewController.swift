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
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    //FACEBOOK
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
    //END FACEBOOK
    
    //EMAIL AUTH
    @IBAction func signInBtn(_ sender: UIButton) {
        
        if let email = emailField.text, let password = passwordField.text {
            
            Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                    
                    print("Email auth - firebase")
                } else {
                    
                    Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                        if error != nil {
                            print("Unable to auth with firebase with email")
                        } else {
                            print("User loged in with email - firebase")
                        }
                    })
                }
            })
        }
        
    }
    
    
    
    
    
    
}

