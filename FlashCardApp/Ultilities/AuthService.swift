//
//  AuthService.swift
//  FlashCardApp
//
//  Created by Nguyễn Đức Tân on 27/02/2021.
//  Copyright © 2021 Nguyễn Đức Tân. All rights reserved.
//

import Foundation
import FirebaseAuth

class AuthService {
    
    static let _instance = AuthService()
    
    static var instance: AuthService {
        get {
            return _instance
        }
    }
    
    func login(credential: AuthCredential? = nil,
               email: String? = nil,
               password: String? = nil,
               completion: @escaping (_ success: Bool) -> Void) {
        LoadingHud.show()
        if let credential = credential {
            Auth.auth().signIn(with: credential) { (result, error) in
                LoadingHud.hide()
                if let error = error {
                    UIAlertController.showError(message: error.localizedDescription)
                    completion(true)
                } else {
                    completion(false)
                }
            }
        } else if let email = email,
                  let password = password {
            Auth.auth().signIn(withEmail: email, password: password) {(result, error) in
                LoadingHud.hide()
                if let error = error {
                    UIAlertController.showError(message: error.localizedDescription)
                    completion(false)
                } else {
                    completion(true)
                }
            }
        }
    }
    
    func logout(completion: (_ success: Bool) -> Void) {
        if let _ = try? Auth.auth().signOut() {
            DataLocal.removeObject(AppKey.accountType)
            completion(true)
        } else {
            UIAlertController.showError(message: "Can't sign out!!!")
            completion(false)
        }
    }
    
    func register(email: String, password: String, completion: @escaping (_ success: Bool) -> Void) {
        LoadingHud.show()
        Auth.auth().createUser(withEmail: email,
                               password: password) {(result, error) in
            LoadingHud.hide()
            if let error = error {
                UIAlertController.showError(message: error.localizedDescription)
                completion(false)
            } else {
                guard let user = Auth.auth().currentUser else {
                    completion(false)
                    return
                }
                user.reload { (error) in
                    if let error = error {
                        UIAlertController.showError(message: error.localizedDescription)
                        completion(false)
                    }
                    switch user.isEmailVerified {
                    case true:
                        UIAlertController.showError(message: Localizable.emailExisted, tittle: "")
                        try! Auth.auth().signOut()
                        completion(false)
                        return
                    case false:
                        user.sendEmailVerification { (error) in
                            if let error = error {
                                UIAlertController.showError(message: error.localizedDescription)
                                try! Auth.auth().signOut()
                                completion(false)
                            } else {
                                completion(true)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func checkAuth() -> AppConstant.AuthError {
        if Auth.auth().currentUser == nil {
            return AppConstant.AuthError.noUser
        } else if Auth.auth().currentUser?.isEmailVerified == false {
            return AppConstant.AuthError.mailVerify
        } else {
            return AppConstant.AuthError.noError
        }
    }
    
    func resetPassword(email: String, completion: @escaping (_ success: Bool) -> Void) {
        LoadingHud.show()
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            LoadingHud.hide()
            if let error = error {
                UIAlertController.showError(message: error.localizedDescription)
                completion(false)
                return
            }
            completion(true)
        }
    }
}
