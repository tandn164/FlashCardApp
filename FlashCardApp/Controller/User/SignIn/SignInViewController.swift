//
//  SignInViewController.swift
//  FlashCardApp
//
//  Created by Nguyễn Đức Tân on 9/6/20.
//  Copyright © 2020 Nguyễn Đức Tân. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class SignInViewController: BaseViewController {
    
    @IBOutlet weak var facebookImageView: UIImageView!
    @IBOutlet weak var functionView: UIView!
    @IBOutlet weak var twitterImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isHiddenNavBar = true
        functionView.layer.cornerRadius = 20
        setGesture()
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
        loginManager.logIn(permissions: [""], from: self) {[weak self] (result, error) in
            
            if let error = error {
                UIAlertController.showError(message: error.localizedDescription)
                return
            }
            
            if !(result?.isCancelled ?? false) {
                guard let token = AccessToken.current, !token.isExpired else {
                    return
                }
                print(token.tokenString)
                let alertController = UIAlertController(title: "",
                                                        message: token.tokenString,
                                                        preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default)
                alertController.addAction(action)
                self?.present(alertController, animated: true)
            }
        }
    }
    
    @objc func twitterLogin() {
        
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
}
