//
//  RegisterViewController.swift
//  GeoStepz
//
//  Created by Lee, Sang on 1/5/16.
//  Copyright © 2016 Sang Lee. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class RegisterViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordReentryField: UITextField!
    @IBAction func registerButton(sender: UIButton) {
        if !registerFormIsValid() {
            UtilitiesHelper.getAlertInstance(self, title: "Register Error", message: "Invalid registration information provided.", hasTextField: false, textFieldValue: "", type: "ok")
        } else {
            ProfileHelper.registerUser(self, email: emailField.text!, username: usernameField.text!, password: passwordField.text!)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        passwordField.secureTextEntry = true
        passwordReentryField.secureTextEntry = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func registerFormIsValid() -> Bool {
        // TODO: real validation (if statement should return false, true for now for testing purposes)
        if emailField.text == "a" && usernameField.text == "a" && passwordField.text == "a" && passwordReentryField.text == "a" && passwordField.text == passwordReentryField.text {
            return true
        } else {
            return true
        }
    }
}

