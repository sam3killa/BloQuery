//
//  ViewController.swift
//  BloQuery
//
//  Created by Samuel Shih on 4/21/16.
//  Copyright © 2016 Samuel Shih. All rights reserved.
//

import UIKit
import Firebase

let myRootRef = Firebase(url:"https://fiery-heat-7937.firebaseio.com")

class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    
//    let myRootRef = Firebase(url:"https://fiery-heat-7937.firebaseio.com")

    // User Dictionary
    var user = [
        "firstName": "",
        "lastName": "",
        "email": "",
        "pictureURL": ""
    ]
    
    // Create an immutable login button with email read permission
    let loginButton: FBSDKLoginButton = {
        let button = FBSDKLoginButton()
        button.readPermissions = ["email"]
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Firebase Implementation
        myRootRef.setValue("Do you have data? You'll love Firebase.")
        
        // Add the button to the view and place it in the center
        view.addSubview(loginButton)
        loginButton.center = view.center
        
        // Set self to delegate
        loginButton.delegate = self
        
        // Store the access token
        if let token = FBSDKAccessToken.currentAccessToken() {
            fetchProfile()
        }
    }
    
    func fetchProfile() {
        
        // Getting the email of the user
        let parameters = ["fields": "email, first_name, last_name, picture.type(large)"]
        FBSDKGraphRequest(graphPath: "me", parameters:  parameters).startWithCompletionHandler { (connection, result, error) -> Void in
            
            // Error Handling
            if error != nil {
//                print(error)
                return
            }
            
            // Unwrap email value
            if let email = result["email"] as? String {
                self.user["email"] = email
                myRootRef.setValue(email)

            }
            
            if let first_name = result["first_name"] as? String {
                self.user["firstName"] = first_name
            }
            
            if let last_name = result["first_name"] as? String {
                self.user["lastName"] = last_name
            }
            
            if let picture = result["picture"] as? NSDictionary, data = picture["data"] as? NSDictionary, url = data["url"] as? String {
                self.user["pictureURL"] = url
                    print(url)
            }
            
            var usersRef = myRootRef.childByAppendingPath("users")
            
            usersRef.setValue(self.user)

            print(self.user)
            print(result)
        }
    
    }
    
    // Implement required methods that follow the Login Button Delegate Protocol
    
    // User successfully logged in
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print("Completed Login")
        fetchProfile()
        
        self.performSegueWithIdentifier("homeScreenSegue", sender: self)
        
    }
    
    func loginButtonWillLogin(loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

