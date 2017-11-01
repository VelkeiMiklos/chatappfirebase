//
//  DataServices.swift
//  ChatAppFirebase
//
//  Created by Velkei Miklós on 2017. 11. 01..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import Foundation
import Firebase

class DataService{
    
    static let instance = DataService()
    
    //Db referencia
    public private(set) var REF_BASE = CO_DB_BASE
    //user referencia
    public private(set) var REF_USERS = CO_DB_BASE.child(CO_USERS)
    //group referencia
    public private(set) var REF_GROUPS = CO_DB_BASE.child(CO_GROUPS)
    //message regerencia
    public private(set) var REF_MESSAGE = CO_DB_BASE.child(CO_MESSAGE)
    
    func createDBUser(uid: String, userData: Dictionary<String, Any>){
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
}
