//
//  Messages.swift
//  MyFirstChatApp
//
//  Created by Bhavin on 07/06/17.
//  Copyright © 2017 Bhavin. All rights reserved.
//

import UIKit
import Firebase

class Messages: NSObject {
    
    var fromId: String?
    var toId: String?
    var text: String?
    var timestamp: NSNumber?
    var imageUrl: String?
    var imageWidth: NSNumber?
    var imageHeight: NSNumber?
    
    
    func chatPartnerId() -> String?{
        
        if toId == Auth.auth().currentUser?.uid{
            return fromId!
        }
            
        else{
            return toId!
        }
    }

}
