//
//  SignUpViewController.swift
//  FlashCardApp
//
//  Created by Nguyễn Đức Tân on 9/6/20.
//  Copyright © 2020 Nguyễn Đức Tân. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth
import TwitterKit

protocol SignUpDelegate: class {
    func didSignUp()
}

class SignUpViewController: BaseViewController {
    
    @IBOutlet weak var functionView: UIView!
    @IBOutlet weak var facebookImageView: UIImageView!
    @IBOutlet weak var twitterImageView: UIImageView!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var emailTexField: UITextField!
    @IBOutlet weak var passWordTextField: UITextField!
    @IBOutlet weak var confirmPassWordTextField: UITextField!
    
    weak var delegate: SignUpDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        functionView.layer.cornerRadius = 20
        signUpButton.layer.cornerRadius = signUpButton.frame.height/2
        navigationController?.setNavigationBarHidden(true, animated: false)
        setGesture()
    }

}

// Action
extension SignUpViewController {
    
    func setGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        tap.delegate = self
        view.addGestureRecognizer(tap)
        let facebookTap = UITapGestureRecognizer(target: self, action: #selector(facebookLogin))
        facebookTap.delegate = self
        facebookImageView.addGestureRecognizer(facebookTap)
        let twitterTap = UITapGestureRecognizer(target: self, action: #selector(twitterLogin))
        twitterTap.delegate = self
        twitterImageView.addGestureRecognizer(twitterTap)
    }
    
    @objc func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func facebookLogin() {
        let loginManager = LoginManager()
        loginManager.logOut()
        loginManager.logIn(permissions: ["public_profile"], from: self) {[weak self] (result, error) in
            
            if let error = error {
                UIAlertController.showError(message: error.localizedDescription)
                return
            }
            
            guard let self = self,
                  let facebookResult = result else {
                return
            }
            
            if !facebookResult.isCancelled {
                guard let token = AccessToken.current, !token.isExpired else {
                    return
                }
                LoadingHud.show()
                print(token.tokenString)
                // Connect to firebase auth
                let credential = FacebookAuthProvider.credential(withAccessToken: token.tokenString)
                Auth.auth().signIn(with: credential) { (result, error) in
                    if let error = error {
                        UIAlertController.showError(message: error.localizedDescription)
                        LoadingHud.hide()
                        return
                    } else {
                        self.dismiss(animated: true, completion: {
                            LoadingHud.hide()
                            DataLocal.saveObject(1, forKey: AppKey.accountType)
                            self.delegate?.didSignUp()
                        })
                    }
                }
            }
        }
    }
    
    @objc func twitterLogin() {
        TWTRTwitter.sharedInstance().logIn { [weak self] (session, error) in
            guard let self = self else {
                return
            }
            guard let session = session else {
                if let error = error {
                    if !error.localizedDescription.contains("cancel") {
                        UIAlertController.showError(message: error.localizedDescription)
                    }
                } else {
                    UIAlertController.showError(message: Localizable.userCanceled, tittle: "")
                }
                return
            }
            print(session.authToken)
            print(session.authTokenSecret)
            
            let credential = TwitterAuthProvider.credential(withToken: session.authToken,
                                                            secret: session.authTokenSecret)
            LoadingHud.show()
        
            Auth.auth().signIn(with: credential) { (result, error) in
                if let error = error {
                    UIAlertController.showError(message: error.localizedDescription)
                    LoadingHud.hide()
                    return
                } else {
                    self.dismiss(animated: true, completion: {
                        LoadingHud.hide()
                        DataLocal.saveObject(2, forKey: AppKey.accountType)
                        self.delegate?.didSignUp()
                    })
                }
            }
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
         if touch.view?.isDescendant(of: functionView) == true {
            return false
         }
         return true
    }
    
    @IBAction func signUpPressed(_ sender: UIButton) {
        if checkEdited() {
            view.endEditing(true)
            register(auth: Auth.auth())
        }
    }
    
    func register(auth: Auth) {
        guard let mail = emailTexField.text,
              let password = passWordTextField.text else {
            return
        }
        LoadingHud.show()
        auth.createUser(withEmail: mail,
                        password: password) {[weak self] (result, error) in
            if let error = error {
                UIAlertController.showError(message: error.localizedDescription)
                LoadingHud.hide()
            } else {
                self?.sendMail()
            }
        }
    }
    
    func sendMail() {
        guard let user = Auth.auth().currentUser else {
            LoadingHud.hide()
            return
        }
        user.reload { (error) in
            if let error = error {
                UIAlertController.showError(message: error.localizedDescription)
                LoadingHud.hide()
            }
            switch user.isEmailVerified {
            case true:
                UIAlertController.showError(message: Localizable.emailExisted, tittle: "")
                try! Auth.auth().signOut()
                LoadingHud.hide()
                return
            case false:
                user.sendEmailVerification { (error) in
                    if let error = error {
                        UIAlertController.showError(message: error.localizedDescription)
                        try! Auth.auth().signOut()
                        LoadingHud.hide()
                    } else {
                        self.dismiss(animated: true, completion: {
                            LoadingHud.hide()
                            DataLocal.saveObject(3, forKey: AppKey.accountType)
                            UIAlertController.showError(message: Localizable.checkVerifyMail, tittle: "")
                            self.delegate?.didSignUp()
                        })
                    }
                }
            }
        }
    }
}

extension SignUpViewController: UITextFieldDelegate {
    
    func setupTextField() {
        emailTexField.delegate = self
        passWordTextField.delegate = self
        confirmPassWordTextField.delegate = self
    }
    
    func checkEdited() -> Bool {
        var check = true
        if emailTexField.text == "" {
            emailTexField.placeholder = Localizable.warningEmail
            check = false
        }
        if passWordTextField.text == "" {
            passWordTextField.placeholder = Localizable.warningPassword
            check = false
        } else {
            if confirmPassWordTextField.text != passWordTextField.text {
                confirmPassWordTextField.text = ""
                confirmPassWordTextField.attributedPlaceholder
                    = NSAttributedString(string: Localizable.wrongConfirmPassword,
                                         attributes: [NSAttributedString.Key.foregroundColor : UIColor.red])
                check = false
            }
        }
        return check
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}
