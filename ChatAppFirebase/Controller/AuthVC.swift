//
//  AuthVC.swift
//  ChatAppFirebase
//
//  Created by Velkei Miklós on 2017. 10. 30..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit

class AuthVC: UIViewController, GIDSignInUIDelegate {
    
    var loginManager = FBSDKLoginManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        GIDSignIn.sharedInstance().uiDelegate = self
        //Ha be vagyunk lépve akkor dismiss
        if Auth.auth().currentUser != nil {
            dismiss(animated: true, completion: nil)
        }
    }
    
    func googleLogin(_ credential: AuthCredential){
        GoogleServices.instance.googleLogin(credential) { (success, error) in
            if success{
                self.dismiss(animated: true, completion: nil)
            }else{
                let alertController = UIAlertController(title: CO_ERROR, message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: CO_OK, style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
            
        }
    }
    
    @IBAction func googleBtnWasPressed(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    @IBAction func facebookBtnWasPressed(_ sender: Any) {
        loginManager.logIn(withReadPermissions: [CO_EMAIL], from: self) { (result, error) in
            if let error = error{
                let alertController = UIAlertController(title: CO_ERROR, message: error.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: CO_OK, style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }else if result!.isCancelled{
                let alertController = UIAlertController(title: CO_ERROR, message: CO_CANCEL_FACEBOOK, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: CO_OK, style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }else{
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                FacebookServices.instance.facebookLogin(credential, userLoginComplete: { (success, error) in
                    if success{
                        self.dismiss(animated: true, completion: nil)
                    }else{
                        let alertController = UIAlertController(title: CO_ERROR, message: error?.localizedDescription, preferredStyle: .alert)
                        let defaultAction = UIAlertAction(title: CO_OK, style: .cancel, handler: nil)
                        alertController.addAction(defaultAction)
                        self.present(alertController, animated: true, completion: nil)
                    }
                })
            }
        }
    }
    @IBAction func signInBtnWasPressed(_ sender: Any) {
        let signinVC = storyboard?.instantiateViewController(withIdentifier: CO_SB_SIGNINVC)
        present(signinVC!, animated: true, completion: nil)
    }
}
