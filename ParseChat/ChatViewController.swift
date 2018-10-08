//
//  ChatViewController.swift
//  ParseChat
//
//  Created by user145766 on 10/8/18.
//  Copyright © 2018 Kenia Rioja. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController {

    
    @IBOutlet weak var messageTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    @IBAction func onSend(_ sender: Any) {
        let chatMessage = PFObject(className: "Message")
        chatMessage["text"] = messageTextField.text ?? ""
        
        chatMessage.saveInBackground { (success: Bool, error: Error?) in
            if success {
                print("The message was saved!")
                self.messageTextField.text = ""
            }
            else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
    }
    
}
