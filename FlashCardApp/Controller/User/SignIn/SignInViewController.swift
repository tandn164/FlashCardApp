//
//  SignInViewController.swift
//  FlashCardApp
//
//  Created by Nguyễn Đức Tân on 9/6/20.
//  Copyright © 2020 Nguyễn Đức Tân. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth
import TwitterKit

protocol SignInDelegate: class {
    func didSignIn()
}

class SignInViewController: BaseViewController {
    
    @IBOutlet weak var facebookImageView: UIImageView!
    @IBOutlet weak var functionView: UIView!
    @IBOutlet weak var twitterImageView: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    weak var delegate: SignInDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        functionView.layer.cornerRadius = 20
        signInButton.layer.cornerRadius = signInButton.frame.height/2
        navigationController?.setNavigationBarHidden(true, animated: false)
        setGesture()
        setupTextField()
    }
}

extension SignInViewController {
    
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
                            self.delegate?.didSignIn()
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
                        self.delegate?.didSignIn()
                    })
                }
            }
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        if gestureRecognizer.view == facebookImageView || gestureRecognizer.view == twitterImageView {
            return true
        }
        
        if touch.view?.isDescendant(of: functionView) == true {
            return false
        }
        return true
    }
    
    @IBAction func signInPressed(_ sender: UIButton) {
        guard checkEdited() else {
            return
        }
        guard let mail = emailTextField.text,
              let password = passwordTextField.text else {
            return
        }
        view.endEditing(true)
        LoadingHud.show()
        Auth.auth().signIn(withEmail: mail, password: password) {[weak self] (result, error) in
            LoadingHud.hide()
            if let error = error {
                UIAlertController.showError(message: error.localizedDescription)
                return
            }
            guard let self = self,
                  let _ = result else {
                return
            }
            self.dismiss(animated: true) {
                DataLocal.saveObject(3, forKey: AppKey.accountType)
                self.delegate?.didSignIn()
            }
        }
    }
    
    @IBAction func forgotPasswordPressed(_ sender: UIButton) {
        self.dismiss(animated: true) {
            let viewController = ForgotPasswordViewController()
            viewController.modalPresentationStyle = .overFullScreen
            viewController.modalTransitionStyle = .crossDissolve
            UIViewController.top()?.present(viewController, animated: true, completion: nil)
        }
    }
}

extension SignInViewController: UITextFieldDelegate {
    
    func setupTextField() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func checkEdited() -> Bool {
        var check = true
        if emailTextField.text == "" {
            emailTextField.placeholder = Localizable.warningEmail
            check = false
        }
        if passwordTextField.text == "" {
            passwordTextField.placeholder = Localizable.warningPassword
            check = false
        }
        return check
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}
