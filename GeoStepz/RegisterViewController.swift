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
        if !register() {
            let alert = UtilitiesHelper.getAlertInstance("Register Error", message: "Invalid registration information provided.", hasTextField: false, textFieldValue: "")
            
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                print("OK clicked.")
            }))
            
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MapViewController") as! MapViewController
            self.presentViewController(secondViewController, animated: true, completion: nil)
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

    func register() -> Bool {
        if emailField.text == "a" && usernameField.text == "a" && passwordField.text == "a" && passwordReentryField.text == "a" && passwordField.text == passwordReentryField.text {
            return true
        } else {
            return false
        }
    }
}

