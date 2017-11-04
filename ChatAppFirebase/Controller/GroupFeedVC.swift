//
//  GroupFeedVC.swift
//  ChatAppFirebase
//
//  Created by Velkei Miklós on 2017. 10. 30..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import UIKit
import Firebase
class GroupFeedVC: UIViewController {

    //Outlets
    @IBOutlet weak var groupNameLbl: UILabel!
    @IBOutlet weak var groupMemberLbl: UILabel!
    @IBOutlet weak var messageTextField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()


        // Do any additional setup after loading the view.
    }
    @IBAction func sendBtnWasPressed(_ sender: Any) {
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

