//
//  ViewController.swift
//  Sit Fit
//
//  Created by Nick Cowart on 2/3/15.
//  Copyright (c) 2015 Nick Cowart. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        checkIfLoggedIn()
        
        NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardWillShowNotification, object: nil, queue: NSOperationQueue.mainQueue()) { (notification) -> Void in
            
            if let kbSize = notification.userInfo?[UIKeyboardFrameEndUserInfoKey]?.CGRectValue().size {
                
                self.buttonBottomConstraint.constant = 20 + kbSize.height

                self.view.layoutIfNeeded()
                
//                self.view.frame.origin.y = -kbSize.height
            }
        }
        
        NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardWillHideNotification, object: nil, queue: NSOperationQueue.mainQueue(), usingBlock: { (notification) -> Void in
            
            
            self.buttonBottomConstraint.constant = 20
            
            self.view.layoutIfNeeded()
            
            
        })
    }

    @IBAction func loginRegister(sender: AnyObject) {
        

        
           if  usernameField.text == "" || passwordField.text == ""
        {
            
            var alert = UIAlertController(title: "Error!", message: "All fields must be complete!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
        } else {
            //            var alert = UIAlertController(title: "Logged In!", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
            //            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            //            self.presentViewController(alert, animated: true, completion: nil)
            //
            println("all fields are good and login")
            
            var userQuery = PFUser.query()
            
            userQuery.whereKey("username", equalTo: usernameField.text)
            
            userQuery.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
                
                if objects.count > 0 {
                    
                    self.login()
                    
                } else {
                    
                    self.signUp()
                    
                }
                
            })
            
            //            signUp()
            
        }
        
    }
    
    func login() {
        PFUser.logInWithUsernameInBackground(usernameField.text, password:passwordField.text) {
            (user: PFUser!, error: NSError!) -> Void in
            
            if user != nil {
                println("Logged in as \(user)")
                //                \(user) adding the variable user into a string
                
                        self.isLoggedIn = true
                        self.checkIfLoggedIn()
                
            } else {
                // The login failed. Check error to see why.
                
            }
            
        }
        
    }
    
    func signUp() {
        
        var user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        // other fields can be set just like with PFObject
        
        user.signUpInBackgroundWithBlock {
            //            method specific to parse. jumps back on main thread at { above
            (succeeded: Bool!, error: NSError!) -> Void in
            
            if error == nil {
                // Hooray! Let them use the app now.
                
                
                println(user)
                
                        self.isLoggedIn = true
                        self.checkIfLoggedIn()
                
                self.usernameField.text = ""
                self.passwordField.text = ""
                
            } else {
                
                let errorString = error.userInfo?["error"] as NSString
                // Show the errorString somewhere and let the user try again.
            }
        }
        
    }
    
    
    var isLoggedIn: Bool {
        
        get {
            
            return NSUserDefaults.standardUserDefaults().boolForKey("isLoggedIn")
            
        }
        
        set {
            
            NSUserDefaults.standardUserDefaults().setBool(newValue, forKey: "isLoggedIn")
            NSUserDefaults.standardUserDefaults().synchronize()
            
        }
        
    }
    
    func checkIfLoggedIn() {
        
        println(isLoggedIn)
        
        if isLoggedIn {
            
            var tbc = storyboard?.instantiateViewControllerWithIdentifier("TabBarController") as? UITabBarController
            
            println(UIApplication.sharedApplication().keyWindow)
            
            UIApplication.sharedApplication().keyWindow?.rootViewController = tbc
                // replace this controller with the tabbarcontroller
            
        }
        
    }
    
    



} //End

