//
//  Message.swift
//  ParseChat
//
//  Created by user145766 on 10/8/18.
//  Copyright © 2018 Kenia Rioja. All rights reserved.
//

import UIKit
import Parse

class Message: PFObject, PFSubclassing {
    @NSManaged var user: PFUser!
    @NSManaged var text: String?
    
    class func parseClassName() -> String {
        return "Message"
    }

}
