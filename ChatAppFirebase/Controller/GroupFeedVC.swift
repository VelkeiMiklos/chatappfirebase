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
    @IBOutlet weak var sendBtn: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    var group: Groups?
    var groupMessageArray = [Message]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        sendBtn.bindToKeyboard()
        messageTextField.bindToKeyboard()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        groupNameLbl.text = group?.groupTitle
        DataService.instance.getEmailFromGroup(group: group!) { (returnedEmail) in
            self.groupMemberLbl.text = returnedEmail.joined(separator: ", ")
        }
        //Mindig figyelve legyen a változás
        DataService.instance.REF_GROUPS.observe(.value) { (snapshot) in
            DataService.instance.getGroupMessages(group: self.group!) { (returnedGroupMessage) in
                self.groupMessageArray = returnedGroupMessage
                self.tableView.reloadData()
                
                // Az új feed mindig a legutolsó elem legyen
                if self.groupMessageArray.count > 0{
                    let endIndex = IndexPath(row: self.groupMessageArray.count - 1, section: 0)
                    self.tableView.scrollToRow(at: endIndex, at: .bottom, animated: false)
                }
                
            }
        }
        
    }
    func initData(group: Groups){
        self.group = group
    }
    
    @IBAction func sendBtnWasPressed(_ sender: Any) {
        
        guard let message = messageTextField.text , messageTextField.text != "" else {
            let alertController = UIAlertController(title: CO_ERROR, message: CO_MESSAGE_ERROR, preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: CO_OK, style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
            return
        }
        
        DataService.instance.uploadPost(uid: (Auth.auth().currentUser?.uid)!, message: message, groupKey: group?.key) { (isSuccess) in
            if isSuccess{
                self.messageTextField.text = ""
                self.tableView.reloadData()
            }else{
                let alertController = UIAlertController(title: CO_ERROR, message: CO_POST_ERROR, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: CO_OK, style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
                return
            }
        }
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        //dismiss(animated: true, completion: nil)
        self.dismissDetail()
    }
    
}
extension GroupFeedVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupMessageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let image = UIImage(named: CO_DEFAULT_PROFILE_IMAGE)!
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CO_GROUP_CHAT_FEED_CELL, for: indexPath) as? GroupChatFeedCell else { return UITableViewCell() }
        
        let message = groupMessageArray[indexPath.row]
        cell.configureCell(profileImg: image, email: message.senderId, message: message.message)
        return cell
    }
}

