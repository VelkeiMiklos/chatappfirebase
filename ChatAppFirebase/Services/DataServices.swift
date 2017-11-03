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
    //message referencia
    public private(set) var REF_MESSAGE = CO_DB_BASE.child(CO_MESSAGE)
    //Feed referencia
    public private(set) var REF_FEED = CO_DB_BASE.child(CO_FEED)
    
    //Felhasználó létrehozása
    func createDBUser(uid: String, userData: Dictionary<String, Any>){
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    //Post létrehozása
    func uploadPost(uid: String, message: String, groupKey: String?, feedSendComplete: @escaping (_ isFeedUploadWasSuccess: Bool)->()){
        if groupKey != nil{
            //Csoportban történő beszélgetéskor jön groupkey
        }else{
            //Automatikusan adja ki az id-t
            REF_FEED.childByAutoId().updateChildValues([CO_CONTENT: message, CO_SENDER_ID: uid])
            feedSendComplete(true)
        }
    }
    
    //Üzenetek lekérdezése
    func getAllMessages(returnedMessage: @escaping(_ messages: [Message])->()){
        var messageArray = [Message]()
        REF_FEED.observeSingleEvent(of: .value) { (messageSnapshot) in
            
            //Snapshot-nak lekérni az összes gyerekét
            guard let messageFromSnapshot = messageSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            //Gyereken végig menni és kivenni az adatokat
            for mess in messageFromSnapshot{
                
                let message = mess.childSnapshot(forPath: CO_CONTENT).value as! String
                let senderId = mess.childSnapshot(forPath: CO_SENDER_ID).value as! String
                
                let messageEntity = Message(message: message, senderId: senderId)
                messageArray.append(messageEntity)
            }
            //Vissza adni az üzeneteket
            returnedMessage(messageArray)
        }
    }
    
    func getUserEmailbyUid(uid:String, returnedEmail: @escaping(_ userEmailName: String)->()){
        
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            guard let userFromSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else {return}
            //Ha a gyerekek között itt van a keresett uid akkor meg van az email
            for user in userFromSnapshot{
                if user.key == uid{
                    let u = user.childSnapshot(forPath: CO_EMAIL).value as! String
                    returnedEmail(u)
                }
                
            }

        }
        
    }
    
    
    
}
