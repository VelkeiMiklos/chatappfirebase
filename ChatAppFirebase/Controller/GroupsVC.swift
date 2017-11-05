//
//  SecondViewController.swift
//  ChatAppFirebase
//
//  Created by Velkei Miklós on 2017. 10. 29..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import UIKit
import Firebase
class GroupsVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //Variables
    var groupArray = [Groups]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //A dataservice-ben single event van ez egyszer fut le. Kell egy observe event ami folyamatosan figyeli a változást és lekéri
        DataService.instance.REF_GROUPS.observe(.value) { (snapshot) in
            DataService.instance.getGroups { (returnedGroups) in
                self.groupArray = returnedGroups
                self.tableView.reloadData()
            }
        }
    }
}

extension GroupsVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CO_GROUP_CELL, for: indexPath) as? GroupCell else { return UITableViewCell() }
        
        let group = groupArray[indexPath.row]
        
        cell.configureCell(title: group.groupTitle, description: group.groupDesc, member: group.memberCount)
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let groupFeedVC = storyboard?.instantiateViewController(withIdentifier: CO_SB_GROUP_FEED_VC) as? GroupFeedVC else{return}
        groupFeedVC.initData(group: groupArray[indexPath.row])
        // self.present(groupFeedVC, animated: true, completion: nil)
        //Jobbról present
        self.presentDetail(groupFeedVC)
    }
    
}
