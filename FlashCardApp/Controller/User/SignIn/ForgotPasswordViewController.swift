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
    @IBAction func sendPressed(_ sender: UIButton) {
        guard checkEdited(),
              let email = emailTextField.text else {
            return
        }
        view.endEditing(true)
        LoadingHud.show()
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            LoadingHud.hide()
            if let error = error {
                UIAlertController.showError(message: error.localizedDescription)
                return
            }
            self.dismiss(animated: true, completion: {
                UIAlertController.showError(message: Localizable.checkResetPassword, tittle: "")
            })
        }
    }
    
    func setGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissView() {
        self.dismiss(animated: true, completion: nil)
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
