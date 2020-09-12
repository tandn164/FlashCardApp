//
//  UIImage+Extension.swift
//  FlashCardApp
//
//  Created by Nguyễn Đức Tân on 9/6/20.
//  Copyright © 2020 Nguyễn Đức Tân. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func renderImage(_ name: String, _ color: UIColor? = .black) {
        let origImage = UIImage(named: name)
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        image = tintedImage
        tintColor = color
    }
}
