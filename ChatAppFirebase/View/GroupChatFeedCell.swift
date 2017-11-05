//
//  GroupChatFeedCell.swift
//  ChatAppFirebase
//
//  Created by Velkei Miklós on 2017. 11. 04..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import UIKit

class GroupChatFeedCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var messageContentLbl: UILabel!

    func configureCell(profileImg: UIImage, email: String, message: String){
        self.profileImg.image = profileImg
        self.emailLbl.text = email
        self.messageContentLbl.text = message
    }
}
