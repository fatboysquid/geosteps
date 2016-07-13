//
//  SettingsViewController.swift
//  GeoStepz
//
//  Created by Lee, Sang on 1/5/16.
//  Copyright © 2016 Sang Lee. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBAction func signOutButton(sender: UIButton) {
        //do sign out logic, then redirect to login page

        let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SignInViewController")
        self.presentViewController(secondViewController!, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
