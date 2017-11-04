//
//  Groups.swift
//  ChatAppFirebase
//
//  Created by Velkei Miklós on 2017. 11. 04..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import Foundation
class Groups{
    
    public private(set) var groupTitle: String!
    public private(set) var groupDesc: String!
    public private(set) var memberCount: Int!
    public private(set) var key: String!
    public private(set) var members: [String]
    
    init(groupTitle: String, groupDesc: String, memberCount: Int, key: String, members: [String])  {
        self.groupTitle = groupTitle
        self.groupDesc = groupDesc
        self.memberCount = memberCount
        self.key         = key
        self.members = members
        
    }
    
    
}
