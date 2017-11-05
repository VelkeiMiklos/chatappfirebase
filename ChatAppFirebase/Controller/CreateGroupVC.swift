//
//  CreateGroupVC.swift
//  ChatAppFirebase
//
//  Created by Velkei Miklós on 2017. 10. 29..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import UIKit
import Firebase
class CreateGroupVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var groupMemberLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var emailSearchTxt: CustomTextField!
    @IBOutlet weak var groupTitleTxt: CustomTextField!
    @IBOutlet weak var groupDescTxt: CustomTextField!
    
    //Variables
    var emailArray = [String]()
    var chosenEmailArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.emailSearchTxt.delegate = self
        self.emailSearchTxt.addTarget(self, action: #selector(CreateGroupVC.textFieldDidChanged), for: .editingChanged)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        doneBtn.isHidden = true
        
    }
    //---Actions---
    //Done btn
    @IBAction func doneBtnWasPressed(_ sender: Any) {
        
        var idsArray = [String]()
        
        guard let title = groupTitleTxt.text , groupTitleTxt.text != "" else {
            let alertController = UIAlertController(title: "Error", message: "Please enter a title", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
            return
        }
        guard let description = groupDescTxt.text , groupDescTxt.text != "" else {
            let alertController = UIAlertController(title: "Error", message: "Please enter a description", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
            return
        }
        
        DataService.instance.getIdsbyEmails(emailArray: chosenEmailArray) { (returnedIds) in
            idsArray = returnedIds
            //Magamat is hozzá kell adnom
            idsArray.append((Auth.auth().currentUser?.uid)!)
            
            DataService.instance.createGroup(title: title, description: description, ids: idsArray) { (success) in
                if success{
                    self.dismiss(animated: true, completion: nil)
                }else{
                    let alertController = UIAlertController(title: "Error", message: "The group creatin process was not successful", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                    return
                }
            }
        }
    }
    
    //Close button
    @IBAction func closeBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func textFieldDidChanged(){
        // Ha üres törlés és reload
        if emailSearchTxt.text == ""{
            self.emailArray = []
            self.tableView.reloadData()
            //De ha van benne akkor query
        }else{
            DataService.instance.getEmails(searchQuery: emailSearchTxt.text!, returnedEmails: { (returnedEmails) in
                self.emailArray = returnedEmails
                self.tableView.reloadData()
            })
        }
    }
}

extension CreateGroupVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CO_CREATE_GROUP_CELL, for: indexPath) as? CreateGroupCell else { return UITableViewCell() }
        
        let image = UIImage(named: CO_DEFAULT_PROFILE_IMAGE)!
        let email = emailArray[indexPath.row]
        
        //Ha benne van akkor chekcImg = true ha nincs akkor false
        if chosenEmailArray.contains(emailArray[indexPath.row]){
            cell.configureCell(profileImg: image, email: email, isSelected: true)
        }else{
            cell.configureCell(profileImg: image, email: email, isSelected: false)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cell = tableView.cellForRow(at: indexPath) as? CreateGroupCell else { return }
        
        if !chosenEmailArray.contains(cell.emailLbl.text!){
            chosenEmailArray.append(cell.emailLbl.text!)
            groupMemberLbl.text = chosenEmailArray.joined(separator: ", ")
            doneBtn.isHidden = false
        }else{
            //Mindenkit vissza ad aki nem az emailLbl.text, ezzel eltávolítjuk
            chosenEmailArray = chosenEmailArray.filter({ $0 != cell.emailLbl.text! })
            if chosenEmailArray.count >= 1{
                groupMemberLbl.text = chosenEmailArray.joined(separator: ", ")
            }else{
                groupMemberLbl.text = "add people to your group..."
                doneBtn.isHidden = true
            }
        }
    }
    
}
//Texfield "vizsgálatához"
extension CreateGroupVC: UITextFieldDelegate{
    
}
