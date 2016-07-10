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
            let alert = UtilitiesHelper.getAlertInstance("Login Error", message: "Invalid username/password.", hasTextField: false, textFieldValue: "")

            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                print("OK clicked.")
            }))

            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("UITabBarControllerMain") as! UITabBarController
            self.presentViewController(secondViewController, animated: true, completion: nil)
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

