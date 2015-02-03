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
        
        isLoggedIn = true
        
        checkIfLoggedIn()
        
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
    
    



}

