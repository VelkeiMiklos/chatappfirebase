//
//  AuthVC.swift
//  ChatAppFirebase
//
//  Created by Velkei Miklós on 2017. 10. 30..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import UIKit
import Firebase
class AuthVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //Ha be vagyunk lépve akkor dismiss
        if Auth.auth().currentUser != nil {
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func signInBtnWasPressed(_ sender: Any) {
        let signinVC = storyboard?.instantiateViewController(withIdentifier: CO_SB_SIGNINVC)
        present(signinVC!, animated: true, completion: nil)
    }
}
