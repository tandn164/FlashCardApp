//
//  ShadowView.swift
//  FlashCardApp
//
//  Created by Nguyễn Đức Tân on 06/03/2021.
//  Copyright © 2021 Nguyễn Đức Tân. All rights reserved.
//

import UIKit

class ShadowView: UIView {

    var setupShadowDone: Bool = false
    
    public func setupShadow() {
        if setupShadowDone { return }
        self.layer.cornerRadius = 8
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.1
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds,
                                             byRoundingCorners: .allCorners,
                                             cornerRadii: CGSize(width: 8,
                                                                 height:8)).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    
        setupShadowDone = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupShadow()
    }
}
