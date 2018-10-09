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
        chatTableView.dataSource = self
        chatTableView.rowHeight = UITableView.automaticDimension
        chatTableView.estimatedRowHeight = 50
        
        /*
         tableView.insertSubview(refreshControl, at: 0) //0 for the very top
         tableView.rowHeight = UITableViewAutomaticDimension
         tableView.estimatedRowHeight = 50
 */
        
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
        query?.findObjectsInBackground(block: { (objects: [PFObject]?, error: Error?) in
            if error == nil {
                //successfully found the objects
                if let objects = objects {
                    self.messages = objects as! [Message]
                }
            }
            else {
                print("There was an error fetching the objects")
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chatCell = ChatCell()
        
        return chatCell
    }
    
}
