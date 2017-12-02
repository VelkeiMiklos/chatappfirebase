//
//  GoogleServices.swift
//  ChatAppFirebase
//
//  Created by Velkei Miklós on 2017. 12. 02..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import Foundation
import Firebase
import GoogleSignIn
class GoogleServices{
    
    static let instance = GoogleServices()
    
    func googleLogin(_ credential: AuthCredential, userLoginComplete: @escaping (_ isUserLoginSuccess: Bool, _ error: Error?)->()){
        Auth.auth().signIn(with: credential) { (user, error) in
            if let error = error{
                debugPrint(error.localizedDescription)
                userLoginComplete(false, error)
                return
            }else{
                print("You have successfully logged in with the google+")
                userLoginComplete(true, nil)
            }
        }
    }
}
