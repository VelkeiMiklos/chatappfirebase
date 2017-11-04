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
    
    //Email lekérdezése uid alapján
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
    
    //Le kell kérdezni az összes email-t keresés alapján
    func getEmails(searchQuery: String, returnedEmails: @escaping(_ userEmailArray:[String])->()){
        var emailArray = [String]()
        REF_USERS.observe(.value) { (userSnapshot) in
            guard let userFromSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for user in userFromSnapshot{
                let email = user.childSnapshot(forPath: CO_EMAIL).value as! String
                if email.contains(searchQuery){
                    emailArray.append(email)
                }
            }
            returnedEmails(emailArray)
        }
    }
    
    //UID-k lekérdezése
    func getIdsbyEmails(emailArray: [String], returnedIds: @escaping(_ idsArray:[String])->()){

        REF_USERS.observeSingleEvent(of: .value) { (usersSnapshot) in
           var idsArray = [String]()
            guard let userFromSnapshot = usersSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for user in userFromSnapshot{
                let email = user.childSnapshot(forPath: CO_EMAIL).value as! String
                if emailArray.contains(email){
                    idsArray.append(user.key)
                }
            }
            returnedIds(idsArray)
        }
    }
    //Csoport létrehozása
    func createGroup(title: String, description: String, ids: [String], handler: @escaping(_ groupCreated: Bool)->()){
        REF_GROUPS.childByAutoId().updateChildValues(["title" : title,
                                                      "description": description,
                                                      "members": ids ])
        handler(true)
    }
    //
    func getGroups(returnedGroups: @escaping(_ returnedGroupsArray:[Groups])->()){
        var groupsArray = [Groups]()
        REF_GROUPS.observeSingleEvent(of: .value) { (groupsSnapshot) in
            guard let groupsFromSnapshot = groupsSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for group in groupsFromSnapshot{
                let title = group.childSnapshot(forPath: CO_TITLE).value as! String
                let description = group.childSnapshot(forPath: CO_DESCRIPTION).value as! String
                let memberArray = group.childSnapshot(forPath: CO_MEMBERS).value as! [String]
                //Azokat a csoportokat mutassa amiben a bejelentkezett felh. benne van
                if memberArray.contains((Auth.auth().currentUser?.uid)!){
                    let group = Groups(groupTitle: title, groupDesc: description, memberCount: memberArray.count, key: group.key, members: memberArray)
                    groupsArray.append(group)
                }
            }
            returnedGroups(groupsArray)
        }
    }
    
}
