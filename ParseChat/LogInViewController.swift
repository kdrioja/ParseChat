//
//  LogInViewController.swift
//  ParseChat
//
//  Created by user145766 on 10/8/18.
//  Copyright © 2018 Kenia Rioja. All rights reserved.
//

import UIKit
import Parse

class LogInViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorLabel.text = "   "
        
    }
    
    
    @IBAction func onSignUp(_ sender: Any) {
        let username = usernameTextField.text
        let password = passwordTextField.text
        
        if (username?.isEmpty)! || (password?.isEmpty)! {
            errorLabel.text = "Input valid username and password1"
            
            
        }
        else {
            let newUser = PFUser()
            
            newUser.username = username
            newUser.password = password
            
            newUser.signUpInBackground { (success: Bool, error: Error?) in
                if success {
                    print("Yay created a user!")
                }
                else {
                    print(error?.localizedDescription)
                    
                    if error?._code == 202 {
                        print("Username is taken")
                        self.errorLabel.text = "Account already exists"
                    }
                }
            }        }
    }
    
    @IBAction func onLogIn(_ sender: Any) {
        let username = usernameTextField.text
        let password = passwordTextField.text
        
        if (username?.isEmpty)! || (password?.isEmpty)! {
            errorLabel.text = "Input valid username and password3"
            
            }
        else {
            PFUser.logInWithUsername(inBackground: username!, password: password!) { (user: PFUser?, error: Error?) in
                if user != nil {
                    print("You're logged in!")
    
                }
                else {
                    self.errorLabel.text = "Invalid username or password2"
                }
    
            }
        
        }
    
    
    
    
}
}
