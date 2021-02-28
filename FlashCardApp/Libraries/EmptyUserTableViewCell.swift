//
//  EmptyUserTableViewCell.swift
//  FlashCardApp
//
//  Created by Nguyễn Đức Tân on 10/16/20.
//  Copyright © 2020 Nguyễn Đức Tân. All rights reserved.
//

import UIKit
import FirebaseAuth

class EmptyUserTableViewCell: UITableViewCell {
    
    lazy var title: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .primaryColor
        if Auth.auth().currentUser == nil {
            label.text = "Please sign in to use!!!"
        } else if Auth.auth().currentUser?.isEmailVerified == false {
            label.text = "Please verify your email to user!!!"
        }
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        addSubview(label)
        
        return label
    }()
    
    lazy var button: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .primaryColor
        button.setTitle("Resend verify mail", for: .normal)
        button.addTarget(self, action: #selector(resendVerifyMail), for: .touchUpInside)
        button.isHidden = true
        addSubview(button)
        
        return button
    }()

    override func layoutSubviews() {
        selectionStyle = .none
        title.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        title.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        title.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8).isActive = true
        
        button.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        button.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 15).isActive = true
        button.widthAnchor.constraint(equalTo: title.widthAnchor).isActive = true
        button.layer.cornerRadius = button.frame.height/2
        guard let user = Auth.auth().currentUser else {
            return
        }
        button.isHidden = user.isEmailVerified
    }
    
    @objc func resendVerifyMail() {
        guard let user = Auth.auth().currentUser else {
            return
        }
        LoadingHud.show()
        user.sendEmailVerification { (error) in
            if let error = error {
                UIAlertController.showError(message: error.localizedDescription)
                return
            }
            LoadingHud.hide()
            UIAlertController.showAlert(message: Localizable.checkVerifyMail)
        }
    }
    
    override func prepareForReuse() {
        button.isHidden = Auth.auth().currentUser?.isEmailVerified ?? true
    }
}
