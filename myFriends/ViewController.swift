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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
            }
        }
    }


}

