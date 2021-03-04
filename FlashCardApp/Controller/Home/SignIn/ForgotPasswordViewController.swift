//
//  ForgotPasswordViewController.swift
//  FlashCardApp
//
//  Created by Nguyễn Đức Tân on 10/17/20.
//  Copyright © 2020 Nguyễn Đức Tân. All rights reserved.
//

import UIKit
import FirebaseAuth

class ForgotPasswordViewController: BaseViewController {

    @IBOutlet weak var functionView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        sendButton.layer.cornerRadius = sendButton.frame.height / 2
        functionView.layer.cornerRadius = 20
        setupTextField()
        setGesture()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        guard checkEdited(),
              let email = emailTextField.text else {
            return
        }
        view.endEditing(true)
        AuthService.instance.resetPassword(email: email) { (result) in
            if result {
                self.dismiss(animated: true, completion: {
                    UIAlertController.showAlert(message: Localizable.checkResetPassword)
                })
            }
        }
    }
    
    func setGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissView() {
        if emailTextField.isEditing {
            view.endEditing(true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
        
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isDescendant(of: functionView) == true {
            return false
        }
        return true
    }
}

extension ForgotPasswordViewController: UITextFieldDelegate {
    func setupTextField() {
        emailTextField.delegate = self
    }
    
    func checkEdited() -> Bool {
        var check = true
        if emailTextField.text == "" {
            emailTextField.placeholder = Localizable.warningEmail
            check = false
        }
        return check
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}
