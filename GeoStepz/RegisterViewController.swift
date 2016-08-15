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
            showRegisterError("Invalid registration information provided.")
        } else {
            FIRAuth.auth()?.createUserWithEmail(emailField.text!, password: passwordField.text!) { (user, error) in

                if error == nil {
                    print("Successfully created user!")

                    let user:User = User(
                        id: user!.uid,
                        username: self.usernameField.text!,
                        email: self.emailField.text!,
                        password: self.passwordField.text!
                    )

                    ProfileHelper.registerUser(user)
                    ProfileHelper.logInUser(user, currentViewController: self)
                } else {
                    print("Error creating user!")
                    self.showRegisterError("Error authenticating.")
                }
            }
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

    func showRegisterError(message: String) {
        let alert = UtilitiesHelper.getAlertInstance(self, title: "Register Error", message: message, hasTextField: false, textFieldValue: "")
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            print("OK clicked.")
        }))
    }
}

