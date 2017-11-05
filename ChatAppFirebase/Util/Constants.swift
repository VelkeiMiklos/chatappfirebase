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
let CO_FEED   = "feed"

//Azonosítók
let CO_CONTENT = "content"
let CO_SENDER_ID = "senderId"
let CO_EMAIL     = "email"
let CO_PROVIDER  = "provider:"
let CO_TITLE     = "title"
let CO_DESCRIPTION = "description"
let CO_MEMBERS     = "members"

//Storyboard azonosítók
let CO_SB_AUTHVC = "AuthSB"
let CO_SB_SIGNINVC = "SigninSB"
let CO_SB_GROUP_FEED_VC = "GroupFeedSB"

//Cells
let CO_FEED_CELL = "feedCell"
let CO_CREATE_GROUP_CELL = "createGroupCell"
let CO_GROUP_CELL = "groupCell"
let CO_GROUP_CHAT_FEED_CELL = "groupChatFeedCell"

//Image
let CO_DEFAULT_PROFILE_IMAGE = "defaultProfileImage"
