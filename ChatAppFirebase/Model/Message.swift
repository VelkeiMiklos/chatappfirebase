//
//  Message.swift
//  ChatAppFirebase
//
//  Created by Velkei Miklós on 2017. 11. 03..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import Foundation
class Message{
    
    public private(set) var message: String!
    public private(set) var senderId: String!
    
    init(message: String, senderId: String)  {
        self.message = message
        self.senderId = senderId
    }
    
}
