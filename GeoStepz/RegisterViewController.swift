//
//  RegisterViewController.swift
//  GeoStepz
//
//  Created by Lee, Sang on 1/5/16.
//  Copyright © 2016 Sang Lee. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordReentryField: UITextField!
    @IBAction func registerButton(sender: UIButton) {
        if !registerFormIsValid() {
            let alert = UtilitiesHelper.getAlertInstance(self, title: "Register Error", message: "Invalid registration information provided.", hasTextField: false, textFieldValue: "")
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                print("OK clicked.")
            }))
        } else {
            let user:User = User(
                username: usernameField.text!,
                email: emailField.text!,
                password: passwordField.text!
            )

            LoginHelper.logInUser(user, currentViewController: self, targetViewControllerName: "MapViewController")
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
        if emailField.text == "a" && usernameField.text == "a" && passwordField.text == "a" && passwordReentryField.text == "a" && passwordField.text == passwordReentryField.text {
            return true
        } else {
            return false
        }
    }
}

