//
//  UIView+Extension.swift
//  FlashCardApp
//
//  Created by Nguyễn Đức Tân on 27/02/2021.
//  Copyright © 2021 Nguyễn Đức Tân. All rights reserved.
//

import UIKit

// MARK: - UIView
extension UIView {
    
    public func addInnerShadow(topColor: UIColor = UIColor.black.withAlphaComponent(0.1)) {
        let shadowLayer = CAGradientLayer()
        shadowLayer.cornerRadius = layer.cornerRadius
        shadowLayer.colors = [
            topColor.cgColor,
            UIColor.white.withAlphaComponent(0).cgColor
        ]
        shadowLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        shadowLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        shadowLayer.frame = CGRect(x: 0.0,
                                   y: 0.0,
                                   width: frame.width,
                                   height: 10)
        layer.addSublayer(shadowLayer)
    }
    
    func addBottomInnerShadow(bottomColor: UIColor = UIColor.black.withAlphaComponent(0.1)) {
        let shadowLayer = CAGradientLayer()
        shadowLayer.cornerRadius = layer.cornerRadius
        shadowLayer.colors = [
            bottomColor.cgColor,
            UIColor.white.withAlphaComponent(0).cgColor
        ]
        shadowLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        shadowLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        shadowLayer.frame = CGRect(x: 0.0,
                                   y: frame.height - 10,
                                   width: frame.width,
                                   height: 10)

        layer.addSublayer(shadowLayer)
    }
}
