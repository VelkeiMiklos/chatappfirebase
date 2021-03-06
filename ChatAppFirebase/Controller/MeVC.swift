//
//  MeVC.swift
//  ChatAppFirebase
//
//  Created by Velkei Miklós on 2017. 10. 29..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit
class MeVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil{
            emailLbl.text = Auth.auth().currentUser?.email
        }
    }
    
    
    //---Actions---
    
    //Kilépés
    @IBAction func singOutBtnWasPressed(_ sender: Any) {
        
        let logOutMenu = UIAlertController(title: nil, message: CO_LOGOUT_MESSAGE, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: CO_CANCEL, style: .cancel, handler: nil)
        let logOutAction = UIAlertAction(title: CO_LOGOUT, style: .default, handler: { (UIAlertAction) in
            
            AuthService.instance.logoutUser { (islogoutSuccessfull, logoutError) in
                if islogoutSuccessfull{
                    let loginVC = self.storyboard?.instantiateViewController(withIdentifier: CO_SB_AUTHVC)
                    self.present(loginVC!, animated: true, completion: nil)
                }else{
                    //Logout nem volt siekres
                    let alertController = UIAlertController(title: CO_ERROR, message: logoutError?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIKit.UIAlertAction(title: CO_OK, style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
            
        })
        
        logOutMenu.addAction(cancelAction)
        logOutMenu.addAction(logOutAction)
        
        self.present(logOutMenu, animated: true, completion: nil)
    
    }

    
}
