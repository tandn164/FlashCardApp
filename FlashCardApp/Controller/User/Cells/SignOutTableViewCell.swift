//
//  SignOutTableViewCell.swift
//  FlashCardApp
//
//  Created by Nguyễn Đức Tân on 10/16/20.
//  Copyright © 2020 Nguyễn Đức Tân. All rights reserved.
//

import UIKit
import FirebaseAuth

protocol SignOutDelegate: class {
    func didSignOut()
}

class SignOutTableViewCell: UITableViewCell {

    @IBOutlet weak var signOutButton: UIButton!
    weak var delegate: SignOutDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        signOutButton.layer.cornerRadius = signOutButton.frame.height/2
        signOutButton.layer.borderWidth = 2
        signOutButton.layer.borderColor = UIColor.primaryColor?.cgColor
    }
    
    @IBAction func signOutPressed(_ sender: UIButton) {
        LoadingHud.show()
        if let _ = try? Auth.auth().signOut() {
            LoadingHud.hide()
            DataLocal.removeObject(AppKey.accountType)
            delegate?.didSignOut()
        } else {
            LoadingHud.hide()
            UIAlertController.showError(message: "Can't sign out!!!")
        }
    }
}
