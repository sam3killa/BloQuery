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
            
            if let last_name = result["last_name"] as? String {
                self.user["lastName"] = last_name
            }
            
            if let picture = result["picture"] as? NSDictionary, data = picture["data"] as? NSDictionary, url = data["url"] as? String {
                self.user["pictureURL"] = url
                    print(url)
            }
            
            let usersRef = myRootRef.childByAppendingPath("users")
            
            myRootRef.authWithOAuthProvider("facebook", token: FBSDKAccessToken.currentAccessToken().tokenString, withCompletionBlock: { (error, authData) in
                
                // Storing info to a user dictionary
                if let error = error {
                
                    print(error.localizedDescription)
                    
                }
                
                let userDictionary = ["provider": authData.provider, "email": self.user["email"], "first_name":self.user["firstName"], "last_name":self.user["lastName"], "picture":self.user["pictureURL"]]
                
                let usersReference = usersRef.childByAppendingPath(authData.uid)
                usersReference.setValue(userDictionary)
                
                NSUserDefaults.standardUserDefaults().setObject(authData.uid, forKey: "uid")
                
                self.performSegueWithIdentifier("homeScreenSegue", sender: self)

            })
            
            // Get AccessToken from facebook
            // Call AuthWithOAuthProvider
            // Add the userID and provider into my user dictionary
            // Store ID into UserDefaults
            // Get the userID and put it into the create question
            
            
            //    NSString *accessToken = [[FBSDKAccessToken currentAccessToken] tokenString];
            //    [dataService.rootRef authWithOAuthProvider:@"facebook" token:accessToken withCompletionBlock:^(NSError error, FAuthData authData) {
            //    if (error) {
            //    NSLog(@"Login failed. %@", error);
            //    } else {
            //    NSLog(@"Logged in! %@", authData);
            //
            //    NSDictionary *user = @{@"provider" : authData.provider, @"TestProp" : @"cool"};
            //    [dataService createFirebaseUser:authData.uid user:user];
            //
            //    [[NSUserDefaults standardUserDefaults]setObject:authData.uid forKey:KEY_UID];
            //    [self performSegueWithIdentifier:SEGUE_LOGGED_IN sender:nil];
            //    }
            //    }];                                        }
            
//            usersRef.setValue(self.user)

            print(self.user)
            print(result)
        }
    
    }
    
    // Implement required methods that follow the Login Button Delegate Protocol

    // User successfully logged in
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print("Completed Login")
        fetchProfile()
        
        
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

