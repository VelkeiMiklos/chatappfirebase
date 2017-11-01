//
//  LoginVC.swift
//  ChatAppFirebase
//
//  Created by Velkei Miklós on 2017. 10. 30..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import UIKit
import Firebase
class SigninVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Actions
    @IBAction func closeBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signInBtnWasPressed(_ sender: Any) {

          //Email üres, akkor üzenet
        guard let email = emailTextField.text , emailTextField.text != "" else {
            let alertController = UIAlertController(title: "Error", message: "Please enter your email", preferredStyle: .alert)

            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)

            present(alertController, animated: true, completion: nil)
            return

        }
        //Password üres, akkor üzenet
        guard let password = passwordTextField.text , passwordTextField.text != "" else {
            let alertController = UIAlertController(title: "Error", message: "Please enter your password", preferredStyle: .alert)

            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)

            present(alertController, animated: true, completion: nil)
            return

        }

//        AuthService.instance.loginUser(email: email, password: password) { (loginWasSuccess, loginError) in
//            if loginWasSuccess{
//                self.dismiss(animated: true, completion: nil)
//            }else{
//                //Login nem volt siekres
//                let alertController = UIAlertController(title: "Error", message: loginError?.localizedDescription, preferredStyle: .alert)
//                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//                alertController.addAction(defaultAction)
//
//                self.present(alertController, animated: true, completion: nil)
//            }
//        }
        //Regisztráció
        AuthService.instance.registerUser(email: email, password: password) { (isRegisterSuccess, registerError) in
            if isRegisterSuccess{
                self.dismiss(animated: true, completion: nil)
                AuthService.instance.loginUser(email: email, password: password, userLoginComplete: { (isLoginRegSuccess, loginErr) in
                    if isLoginRegSuccess{
                        self.dismiss(animated: true, completion: nil)

                    }else{
                        let alertController = UIAlertController(title: "Error", message: loginErr?.localizedDescription, preferredStyle: .alert)
                        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alertController.addAction(defaultAction)
                        self.present(alertController, animated: true, completion: nil)
                    }
                })
            }else{
                //Regisztráció nem volt siekres
                let alertController = UIAlertController(title: "Error", message: registerError?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }

    }
}
