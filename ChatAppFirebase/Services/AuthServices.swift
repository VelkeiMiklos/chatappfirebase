//
//  AuthServices.swift
//  ChatAppFirebase
//
//  Created by Velkei Miklós on 2017. 11. 01..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import Foundation
import Firebase
class AuthService{
    static let instance = AuthService()
    
    func registerUser(email: String, password: String, userCreationComplete: @escaping (_ isSuccess: Bool, _ error: Error?)->() ){
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let firebaseError = error{
                print(firebaseError.localizedDescription)
                userCreationComplete(true, error)
            }else{
                print("registration was sucessfull --AuthService--")
                guard let user = user else {
                    return userCreationComplete(false, nil)

                }

                let userDetail = [CO_EMAIL: user.email,
                                  CO_PROVIDER: user.providerID]
                DataService.instance.createDBUser(uid: user.uid, userData: userDetail)
                userCreationComplete(true, nil)
            }
        }
    }

    func loginUser(email: String, password: String, userLoginComplete: @escaping (_ isUserLoginSuccess: Bool, _ error: Error?)->()){
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error == nil{
                print("You have successfully logged in --AuthService--")
                userLoginComplete(true, nil)
            }else{
               print("Login process was unsuccessfull --AuthService--")
                userLoginComplete(false, error)
            }
        }
    }

    func logoutUser(userLogoutComplete: @escaping (_ isUserLogoutSuccess: Bool, _ error: Error?)->()){
        do{
            try Auth.auth().signOut()
            userLogoutComplete(true, nil)
        }catch let error as NSError {
            print(error.localizedDescription)
            userLogoutComplete(false,error)
        }

    }
    
}
