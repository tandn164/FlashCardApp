//
//  AccountHeaderCollectionReusableView.swift
//  FlashCardApp
//
//  Created by Nguyễn Đức Tân on 27/02/2021.
//  Copyright © 2021 Nguyễn Đức Tân. All rights reserved.
//

import UIKit
import FirebaseAuth

protocol AccountHeaderDelegate: class {
    func signInPressed()
    func signUpPressed()
}

class AccountHeaderCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var userAvatarImageView: UIImageView!
    @IBOutlet weak var signInButton: RoundButton!
    @IBOutlet weak var signUpButton: RoundButton!
    @IBOutlet weak var userNameLabel: UILabel!
    
    weak var delegate: AccountHeaderDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userAvatarImageView.layer.cornerRadius = userAvatarImageView.frame.height / 2
        setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        setupView()
    }

    func setupView() {
        if let user = Auth.auth().currentUser {
            if user.displayName != nil {
                userNameLabel.text = user.displayName
            } else if user.email != nil {
                userNameLabel.text = user.email?.subStringByString("@")
            } else {
                userNameLabel.text = "Anonymous"
            }
            if let url = user.photoURL {
                let urlString = url.absoluteString
                userAvatarImageView.loadImage(urlString)
            } else {
                userAvatarImageView.renderImage("unknownUserDefault", .primaryColor)
            }
            signInButton.isHidden = true
            signUpButton.isHidden = true
            userNameLabel.isHidden = false
        } else {
            userAvatarImageView.renderImage("unknownUserDefault", .primaryColor)
            signInButton.isHidden = false
            signUpButton.isHidden = false
            userNameLabel.isHidden = true
        }
    }
    
    @IBAction func signInPressed(_ sender: UIButton) {
        delegate?.signInPressed()
    }
    
    @IBAction func signUpPressed(_ sender: UIButton) {
        delegate?.signUpPressed()
    }
}
