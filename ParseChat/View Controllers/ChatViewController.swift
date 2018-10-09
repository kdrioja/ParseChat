//
//  ChatViewController.swift
//  ParseChat
//
//  Created by user145766 on 10/8/18.
//  Copyright © 2018 Kenia Rioja. All rights reserved.
//

import UIKit
import Parse
import ParseLiveQuery

class ChatViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    var refreshTimer: Timer!
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func onSend(_ sender: Any) {
        let chatMessage = Message()
        chatMessage.text = messageTextField.text ?? ""
        
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
    
    func refresh() {
        let query = Message.query()
        query?.addDescendingOrder("createdAt")
        query?.findObjectsInBackground(block: { (messages: [PFObject]?, error: Error?) in
            <#code#>
        })
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
}
