//
//  UIImage+Extension.swift
//  FlashCardApp
//
//  Created by Nguyễn Đức Tân on 9/6/20.
//  Copyright © 2020 Nguyễn Đức Tân. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func renderImage(_ name: String, _ color: UIColor? = .black) {
        let origImage = UIImage(named: name)
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        image = tintedImage
        tintColor = color
    }
    
    func loadImage(_ imageString: String?, placeholder: UIImage? = nil, completion: (() -> Void)? = nil) {
        guard let url = imageString?.toUrl else { return }
        self.kf.setImage(with: url,
                         placeholder: placeholder,
                         options: nil,
                         progressBlock: nil) { (result) in
                            completion?()
        }
    }
}
