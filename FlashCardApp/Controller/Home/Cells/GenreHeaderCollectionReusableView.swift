//
//  GenreHeaderCollectionReusableView.swift
//  FlashCardApp
//
//  Created by Nguyễn Đức Tân on 28/02/2021.
//  Copyright © 2021 Nguyễn Đức Tân. All rights reserved.
//

import UIKit

class GenreHeaderCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var seeMoreButton: UIView!
    @IBOutlet weak var genreTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        seeMoreButton.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                  action: #selector(seeGenreDetail)))
    }
    
    @objc func seeGenreDetail() {
        let vc = GenreViewController()
        UIViewController.top()?.push(vc)
    }
    
}
