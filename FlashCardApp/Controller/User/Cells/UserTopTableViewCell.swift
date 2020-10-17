//
//  UserTopTableViewCell.swift
//  FlashCardApp
//
//  Created by Nguyễn Đức Tân on 9/6/20.
//  Copyright © 2020 Nguyễn Đức Tân. All rights reserved.
//

import UIKit
import FirebaseAuth

protocol UserTopTableViewCellDelegate: class {
    func signInPressed()
    func signUpPressed()
}

class UserTopTableViewCell: UITableViewCell {

    @IBOutlet weak var userAvatarImageView: UIImageView!
    @IBOutlet weak var signInButton: RoundButton!
    @IBOutlet weak var signUpButton: RoundButton!
    @IBOutlet weak var userNameLabel: UILabel!
    
    weak var delegate: UserTopTableViewCellDelegate?
    let cellHeight: CGFloat = 138
    
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
            userNameLabel.isHidden = false
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
