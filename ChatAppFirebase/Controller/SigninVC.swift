//
//  SigninVC.swift
//  ChatAppFirebase
//
//  Created by Velkei Miklós on 2017. 11. 01..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import UIKit

class SigninVC: UIViewController {
    
    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var passwordTextField: CustomTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //--Actions--
    
    //Bezárás
    @IBAction func closeBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    //Regisztáció
    @IBAction func signInBtnWasPressed(_ sender: Any) {
        
        guard let email = emailTextField.text , emailTextField.text != "" else {
            let alertController = UIAlertController(title: "Error", message: "Please enter your email", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
            return
        }
        guard let password = passwordTextField.text , passwordTextField.text != "" else {
            let alertController = UIAlertController(title: "Error", message: "Please enter your password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
            return
        }
        
        AuthService.instance.registerUser(email: email, password: password) { (isRegistrationSuccess, registrationError) in
            if isRegistrationSuccess{
                AuthService.instance.loginUser(email: email, password: password) { (isLoginSucces, loginError) in
                    if isLoginSucces{
                        print("login was succesfully --SigninVC--")
                        self.dismiss(animated: true, completion: nil)
                    }else{
                        let alertController = UIAlertController(title: "Error", message: loginError?.localizedDescription, preferredStyle: .alert)
                        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alertController.addAction(defaultAction)
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
            }else{
                let alertController = UIAlertController(title: "Error", message: registrationError?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
    }
    //Belépés
    @IBAction func loginBtnWasPressed(_ sender: Any) {
        
        guard let email = emailTextField.text , emailTextField.text != "" else {
            let alertController = UIAlertController(title: "Error", message: "Please enter your email", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
            return
        }
        guard let password = passwordTextField.text , passwordTextField.text != "" else {
            let alertController = UIAlertController(title: "Error", message: "Please enter your password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
            return
        }
        AuthService.instance.loginUser(email: email, password: password) { (isLoginSucces, loginError) in
            if isLoginSucces{
                print("login was succesfully --SigninVC--")
                self.dismiss(animated: true, completion: nil)
            }else{
                let alertController = UIAlertController(title: "Error", message: loginError?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
}
