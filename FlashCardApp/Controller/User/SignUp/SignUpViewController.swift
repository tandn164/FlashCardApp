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

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        view.endEditing(true)
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
        if checkEditing() {
            view.endEditing(true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func checkEditing() -> Bool {
        return emailTexField.isEditing || passWordTextField.isEditing || confirmPassWordTextField.isEditing
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
                // Connect to firebase auth
                let credential = FacebookAuthProvider.credential(withAccessToken: token.tokenString)
                AuthService.instance.login(credential: credential) { (success) in
                    if success {
                        self.dismiss(animated: true, completion: {
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
                    UIAlertController.showAlert(message: Localizable.userCanceled)
                }
                return
            }

            let credential = TwitterAuthProvider.credential(withToken: session.authToken,
                                                            secret: session.authTokenSecret)
            AuthService.instance.login(credential: credential) { (success) in
                if success {
                    self.dismiss(animated: true, completion: {
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
        AuthService.instance.register(email: mail, password: password) { (success) in
            if success {
                self.dismiss(animated: true, completion: {
                    DataLocal.saveObject(3, forKey: AppKey.accountType)
                    UIAlertController.showAlert(message: Localizable.checkVerifyMail)
                    self.delegate?.didSignUp()
                })
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
