//
//  SignInViewController.swift
//  GeoStepz
//
//  Created by Lee, Sang on 1/5/16.
//  Copyright © 2016 Sang Lee. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignInViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBAction func loginButton(sender: UIButton) {
        if !logInFormIsValid() {
            UtilitiesHelper.getAlertInstance(self, title: "Login Error", message: "Invalid username or password.", hasTextField: false, textFieldValue: "", type: "ok")
        } else {
            ProfileHelper.logInUser(self, email: emailField.text!, password: passwordField.text!)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        FIRAuth.auth()?.addAuthStateDidChangeListener { auth, user in
            if let user = user {
                //Dev-friendly behavior forces logout if already logged in for easy debugging
                //print(user)
                //ProfileHelper.logOutUser(self)
                //self.passwordField.secureTextEntry = true
                ///*
                // User is signed in.
                print(user)
                ProfileHelper.setLoggedInVariables(user)
                ProfileHelper.redirectSignedInUser(self)
                //*/
            } else {
                // No user is signed in.
                self.passwordField.secureTextEntry = true
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func logInFormIsValid() -> Bool {
        // TODO: add real validation
        if emailField.text == "a" && passwordField.text == "a" {
            return true
        } else {
            return true
        }
    }
}

