//
//  UserTopTableViewCell.swift
//  FlashCardApp
//
//  Created by Nguyễn Đức Tân on 9/6/20.
//  Copyright © 2020 Nguyễn Đức Tân. All rights reserved.
//

import UIKit

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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userAvatarImageView.layer.cornerRadius = userAvatarImageView.frame.height / 2
        if let userName = DataLocal.getObject(AppKey.userName) as? String {
            userNameLabel.isHidden = false
            userNameLabel.text = userName
            if let url = DataLocal.getObject(AppKey.userImageURL) as? String {
                userAvatarImageView.loadImage(url)
            } else {
                if let gender = DataLocal.getObject(AppKey.userGender) as? String {
                    if gender == "male" {
                        userAvatarImageView.renderImage("maleUserDefault", .primaryColor)
                    } else {
                        userAvatarImageView.renderImage("femaleUserDefault", .primaryColor)
                    }
                } else {
                    userAvatarImageView.renderImage("unknownUserDefault", .primaryColor)
                }
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
