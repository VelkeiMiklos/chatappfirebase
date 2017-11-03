//
//  FirstViewController.swift
//  ChatAppFirebase
//
//  Created by Velkei Miklós on 2017. 10. 29..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import UIKit
import Firebase
class FeedVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //Variables
    
    var messageArray = [Message]()
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        initMessages()
    }
    
    //Adatok lekérdetése
    func initMessages(){
        DataService.instance.getAllMessages { (returnedMessagesArray) in
            // A legújabb mindig legfelül legyen
            self.messageArray = returnedMessagesArray.reversed()
             self.tableView.reloadData()
        }
    }

}
extension FeedVC: UITableViewDelegate, UITableViewDataSource{

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CO_FEED_CELL, for: indexPath) as? FeedCell else {
            return UITableViewCell()
        }
        
        let message = messageArray[indexPath.row]
        let image = UIImage(named: CO_DEFAULT_PROFILE_IMAGE)!
        
        DataService.instance.getUserEmailbyUid(uid: message.senderId) { (userEmailbyUid) in
           cell.configureCell(profileImg: image, email: userEmailbyUid,   message: message.message)
        }
        

        return cell
    }
}

