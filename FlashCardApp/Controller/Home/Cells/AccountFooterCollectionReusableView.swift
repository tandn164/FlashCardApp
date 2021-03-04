//
//  AccountFooterCollectionReusableView.swift
//  FlashCardApp
//
//  Created by Nguyễn Đức Tân on 28/02/2021.
//  Copyright © 2021 Nguyễn Đức Tân. All rights reserved.
//

import UIKit

class AccountFooterCollectionReusableView: UICollectionReusableView {
    
    var didAddShadow = false

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if !didAddShadow {
            addBottomInnerShadow()
            didAddShadow = true
        }
    }
    
}
