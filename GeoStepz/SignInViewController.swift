//
//  SignInViewController.swift
//  GeoStepz
//
//  Created by Lee, Sang on 1/5/16.
//  Copyright © 2016 Sang Lee. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBAction func loginButton(sender: UIButton) {
        if !logIn() {
            let alert = UtilitiesHelper.getAlertInstance(self, title: "Login Error", message: "Invalid username/password.", hasTextField: false, textFieldValue: "")
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                print("OK clicked.")
            }))
        } else {
            if DBHelper.getConnectionSuccess() {
                print("Database connection success")

                let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("UITabBarControllerMain") as! UITabBarController
                self.presentViewController(secondViewController, animated: true, completion: nil)
            } else {
                DBHelper.showConnectionError(self)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        passwordField.secureTextEntry = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func logIn() -> Bool {
        if emailField.text == "a" && passwordField.text == "a" {
            return true
        } else {
            return false
        }
    }
}

