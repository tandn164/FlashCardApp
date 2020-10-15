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
                        self.fetchFacebookUserInfomation(facebookResult)
                    }
                }
            }
        }
    }
    
    func fetchFacebookUserInfomation(_ result: LoginManagerLoginResult) {
        let graphRequest : GraphRequest = GraphRequest(graphPath: "me",
                                                       parameters: ["fields" : "id, name, gender"])
        graphRequest.start(completionHandler: {[weak self] (connection,
                                                            result,
                                                            error) -> Void in
            if let error = error {
                UIAlertController.showError(message: error.localizedDescription)
                LoadingHud.hide()
                return
            }
            
            guard let self = self,
                  let result = result else {
                LoadingHud.hide()
                return
            }
            
            if let user : NSString = (result as AnyObject).value(forKey: "name") as? NSString {
                DataLocal.saveObject(user, forKey: AppKey.userName)
            }
            if let facebookId : NSString = (result as AnyObject).value(forKey: "id") as? NSString {
                let profileURL = "https://graph.facebook.com/" + (facebookId as String) + "/picture?type=square"
                DataLocal.saveObject(profileURL, forKey: AppKey.userImageURL)
                print(profileURL)
            }
            if let gender : NSString = (result as AnyObject).value(forKey: "id") as? NSString {
                DataLocal.saveObject(gender, forKey: AppKey.userGender)
            }
            self.dismiss(animated: true, completion: {
                LoadingHud.hide()
                self.delegate?.didSignUp()
            })
        })
        
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
                    UIAlertController.showError(message: "User canceled")
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
                    DataLocal.saveObject(session.userName, forKey: AppKey.userName)
                    self.dismiss(animated: true, completion: {
                        LoadingHud.hide()
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
        
    }
}
