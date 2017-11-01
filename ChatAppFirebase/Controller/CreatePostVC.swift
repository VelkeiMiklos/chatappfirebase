//
//  CreatePostVC.swift
//  ChatAppFirebase
//
//  Created by Velkei Miklós on 2017. 10. 29..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import UIKit
import Firebase
class CreatePostVC: UIViewController {

    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    //---Actions---
    
    //Close
    @IBAction func closeBtnWasPressed(_ sender: Any) {
    }
    
    //Send
    
    @IBAction func sendBtnWasPressed(_ sender: Any) {
    }
}
