//
//  FlashCardCollectionViewCell.swift
//  FlashCardApp
//
//  Created by Nguyễn Đức Tân on 28/02/2021.
//  Copyright © 2021 Nguyễn Đức Tân. All rights reserved.
//

import UIKit
import ALProgressRing

class FlashCardCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var flashCardTitle: UILabel!
    @IBOutlet weak var wordCount: UILabel!
    
    private lazy var progressRing = ALProgressRing()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    func setupView() {
        layer.cornerRadius = 15
        progressView.addSubview(progressRing)
        progressRing.translatesAutoresizingMaskIntoConstraints = false
        progressRing.centerXAnchor.constraint(equalTo: progressView.centerXAnchor).isActive = true
        progressRing.centerYAnchor.constraint(equalTo: progressView.centerYAnchor).isActive = true
        progressRing.widthAnchor.constraint(equalToConstant: 40).isActive = true
        progressRing.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        progressRing.setProgress(0.8, animated: true)
        progressRing.startColor = UIColor.thirdColor ?? .systemPink
        progressRing.endColor = UIColor.primaryColor ?? .systemRed
        progressRing.ringWidth = 5
        progressRing.grooveWidth = 4
    }
}
