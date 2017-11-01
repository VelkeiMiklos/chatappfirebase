//
//  CreateGroupVC.swift
//  ChatAppFirebase
//
//  Created by Velkei Miklós on 2017. 10. 29..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import UIKit

class CreateGroupVC: UIViewController {

    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var groupMemberLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    //---Actions---
    //Done btn
    @IBAction func doneBtnWasPressed(_ sender: Any) {
        
    }
    //Close button
    @IBAction func closeBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
