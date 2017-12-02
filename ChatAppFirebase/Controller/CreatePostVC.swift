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
    
    //Outlets
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
    
    @IBAction func sendBtnWasPressed(_ sender: UIButton) {
        //Ha nem üres és nem is a default szöveg akkor van üzenet
        if textView.text != nil && textView.text != CO_SAY_SOMETHING_HERE {
            DataService.instance.uploadPost(uid: (Auth.auth().currentUser?.uid)!, message: textView.text!, groupKey: nil, feedSendComplete: { (feedSendWasSuccess) in
                if feedSendWasSuccess{
                    self.dismiss(animated: true, completion: nil)
                }else{
                    let alertController = UIAlertController(title: CO_ERROR, message: CO_POST_ERROR, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: CO_OK, style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                    return
                }
            })
        }else{
            
            let alertController = UIAlertController(title: CO_ERROR, message: CO_DEFAULT_POST_MESSAGE, preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: CO_OK, style: .cancel, handler: nil)
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
