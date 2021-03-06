//
//  CardView.swift
//  FlashCardApp
//
//  Created by Nguyễn Đức Tân on 07/03/2021.
//  Copyright © 2021 Nguyễn Đức Tân. All rights reserved.
//

import UIKit

class CardView: ShadowView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var blurView: UIView!
    var isFront = true
    var word: String?
    var meaning: String?
    var rolate: CGFloat = 0
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        initSubviews()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    func initSubviews() {
        let nib = UINib(nibName: "CardView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
        
        contentView.forceConstraintToSuperView()
        contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(flipAction)))
    }
    
    @objc func flipAction() {
        isFront = !isFront
        wordLabel.text = isFront ? word : meaning
    }
    
    func updateStatus(_ gotIt: Bool) {
        if gotIt {
            statusView.backgroundColor = UIColor.fourthColor
            statusLabel.text = "Got it"
            statusLabel.textColor = .black
        } else {
            statusView.backgroundColor = UIColor.secondColor
            statusLabel.text = "Study again"
            statusLabel.textColor = .white
        }
    }
}
