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
        
        refreshTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(refresh), userInfo: nil, repeats: true)
        
    }
    
    @IBAction func onSend(_ sender: Any) {
        let chatMessage = Message()
        chatMessage.user = PFUser.current()!
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
    
    @objc func refresh() {
        let query = Message.query()
        query?.includeKey("user")
        query?.addDescendingOrder("createdAt")
        query?.findObjectsInBackground(block: { (objects: [PFObject]?, error: Error?) in
            if error == nil {
                //successfully found the objects
                if let objects = objects {
                    self.messages = objects as! [Message]
                    self.chatTableView.reloadData()
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
        let cell = chatTableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        
        let message = messages[indexPath.row]
        cell.messageLabel.text = message.text
        
        if let user = message.user as? PFUser {
            cell.usernameLabel.text = user.username
        }
        else {
            cell.usernameLabel.text = "🦊"
        }
        
        return cell
        
        /*
         let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
         
         let movie = movies[indexPath.row]
         let title = movie["title"] as! String
         let overview = movie["overview"] as! String
         
         cell.titleLabel.text = title
         cell.overviewLabel.text = overview
         
         let posterPath = movie["poster_path"] as! String
         let baseURL = "https://image.tmdb.org/t/p/w500"
         let posterURL = URL(string: baseURL + posterPath)! //unwrap with a bang
         
         cell.posterImageView.af_setImage(withURL: posterURL)
         
         //print(overview)
         
         return cell
         */
    }
    
}
