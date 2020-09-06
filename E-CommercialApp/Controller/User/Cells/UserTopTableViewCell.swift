//
//  UserTopTableViewCell.swift
//  E-CommercialApp
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
    weak var delegate: UserTopTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userAvatarImageView.renderImage("unknownUserDefault", .primaryColor)
    }
    
    @IBAction func signInPressed(_ sender: UIButton) {
        delegate?.signInPressed()
    }
    
    @IBAction func signUpPressed(_ sender: UIButton) {
        delegate?.signUpPressed()
    }
    
}
