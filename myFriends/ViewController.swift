//
//  ViewController.swift
//  myFriends
//
//  Created by Long Lac on 3/6/16.
//  Copyright © 2016 Tinyapps. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: UIViewController {

    
    @IBOutlet weak var emailField: MateraiTextField!
    @IBOutlet weak var passwordField: MateraiTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        if NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) != nil
        {
            self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
        }
    }
    
    
    
    @IBAction func fbBtnPressed(sender: UIButton!)
    {
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logInWithReadPermissions(["email"]) { (facebookResult: FBSDKLoginManagerLoginResult!, facebookError: NSError!) -> Void in
            
            if facebookError != nil
            {
                print("Facebook Login failed. Error \(facebookError)")
            }
            else
            {
                let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                print("Successfully logged in with facebook \(accessToken)")
                
                DataService.ds.REF_BASE.authWithOAuthProvider("facebook" , token: accessToken, withCompletionBlock: { error, authData in
                
                    if error != nil
                    {
                        print("Login Failed. \(error)")
                    }
                    else
                    {
                        print("Logged In! \(authData)")
                        NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: KEY_UID)
                        self.performSegueWithIdentifier("SEGUE_LOGGED_IN", sender: nil)
                    }
                
                })
        }
    }
    }

    @IBAction func attemptLogin(sender: UIButton) {
        
        if let email = emailField.text where email != "", let pwd = passwordField.text where pwd != ""
        {
            DataService.ds.REF_BASE.authUser(email, password: pwd, withCompletionBlock: {
                error, authData in
                
                if error != nil
                {
                    print(error)
                    
                    if error.code == STATUS_ACCOUNT_NONEXIST
                    {
                        DataService.ds.REF_BASE.createUser(email, password: pwd, withValueCompletionBlock: { error, result in
                            print("Attempting to create new users")
                            if error != nil
                            {
                                self.showErrorAlert("Count not create account", msg: "Problem creating account. Try something else")
                            }
                            else
                            {
                                NSUserDefaults.standardUserDefaults().setValue(result[KEY_UID], forKey: KEY_UID)
                                
                                DataService.ds.REF_BASE.authUser(email, password: pwd, withCompletionBlock: nil)
                                self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                            }
                        
                        })
                    }
                    else
                    {
                        self.showErrorAlert("Could not login", msg: "Please check your username or passwd")
                    }
                }
                else
                {
                    self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                }
            })
        }
        else
        {
            showErrorAlert("Email and Password Required", msg: "You must enter an email and a password")
        }
    }
    
    
    func showErrorAlert(title: String, msg: String)
    {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        let action = UIAlertAction(title: "ok", style: .Default, handler: nil )
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil )
    }
    
}

