//
//  CreateGroupCell.swift
//  ChatAppFirebase
//
//  Created by Velkei Miklós on 2017. 10. 30..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import UIKit

class CreateGroupCell: UITableViewCell {
    
    @IBOutlet weak var checkImg: UIImageView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    var cellTapped: Bool = false
    
    
    func configureCell(profileImg: UIImage, email:String, isSelected: Bool){
        self.profileImg.image = profileImg
        self.emailLbl.text = email
 
        if isSelected{
            self.checkImg.isHidden = false
        }else{
            checkImg.isHidden = true
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            if cellTapped == false {
                checkImg.isHidden = false
                cellTapped = true
            } else {
                checkImg.isHidden = true
                cellTapped = false
            }
        }
    }
    
}
