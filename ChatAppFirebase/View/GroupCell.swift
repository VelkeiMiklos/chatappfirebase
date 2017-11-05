//
//  GroupCell.swift
//  ChatAppFirebase
//
//  Created by Velkei Miklós on 2017. 10. 30..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {

    @IBOutlet weak var groupTitleLbl: UILabel!
    @IBOutlet weak var groupDescLbl: UILabel!
    @IBOutlet weak var groupMemberLbl: UILabel!
    
    func configureCell(title: String, description: String, member: Int){
        self.groupTitleLbl.text = title
        self.groupDescLbl.text = description
        self.groupMemberLbl.text = "\(member) members"
    }

}
