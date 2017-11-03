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
    @IBOutlet weak var sendBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        sendBtn.bindToKeyboard()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil{
            emailLbl.text = Auth.auth().currentUser?.email
        }
    }
    
    //---Actions---
    
    //Close
    @IBAction func closeBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //Send
    @IBAction func sendBtnWasPressed(_ sender: Any) {
        
        //Ha nem üres és nem is a default szöveg akkor van üzenet
        if textView != nil && textView.text != "Say something here..."{
            DataService.instance.uploadPost(uid: (Auth.auth().currentUser?.uid)!, message: textView.text!, groupKey: nil, feedSendComplete: { (feedSendWasSuccess) in
                if feedSendWasSuccess{
                    
                    self.dismiss(animated: true, completion: nil)
                }else{
                    self.sendBtn.isEnabled = true
                    let alertController = UIAlertController(title: "Error", message: "Your message was not to send", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                    return
                }
            })
        }else{
            
            let alertController = UIAlertController(title: "Error", message: "You cannot send the default message", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
            return
        }
        
    }
}

extension CreatePostVC: UITextViewDelegate{
    //Ha elkezd gépelni akkor törölje ki a default szöveget
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
}
