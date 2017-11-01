//
//  Constants.swift
//  ChatAppFirebase
//
//  Created by Velkei Miklós on 2017. 11. 01..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import Foundation
import Firebase

//Adatbázis referencia =>https://chatappfirebase-7eab3.firebaseio.com/
let CO_DB_BASE = Database.database().reference()

//Gyerek kulcs
let CO_MESSAGE = "message"
let CO_USERS = "users"
let CO_GROUPS = "groups"

//Storyboard azonosítók
let CO_SB_AUTHVC = "AuthSB"
let CO_SB_SIGNINVC = "SigninSB"
