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
            showLoginError("Invalid username/password.")
        } else {
            FIRAuth.auth()?.signInWithEmail(emailField.text!, password: passwordField.text!) { (user, error) in

                if error == nil {
                    self.userAlreadySignedInRedirect()
                    print("Successfully sign-in user!")
                } else {
                    print("Error signing-in user!")
                    self.showLoginError("Error authenticating.")
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        FIRAuth.auth()?.addAuthStateDidChangeListener { auth, user in
            if let user = user {
                // User is signed in.
                print(user)
                self.userAlreadySignedInRedirect()
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

    func showLoginError(message: String) {
        let alert = UtilitiesHelper.getAlertInstance(self, title: "Login Error", message: message, hasTextField: false, textFieldValue: "")
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            print("OK clicked.")
        }))
    }

    func userAlreadySignedInRedirect() {
        let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("UITabBarControllerMain") as! UITabBarController
        self.presentViewController(secondViewController, animated: true, completion: nil)
    }
}

