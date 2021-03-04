//
//  BigFlashcardCollectionViewCell.swift
//  FlashCardApp
//
//  Created by Nguyễn Đức Tân on 04/03/2021.
//  Copyright © 2021 Nguyễn Đức Tân. All rights reserved.
//

import UIKit
import SwipeCellKit

protocol BigFlashcardDelegate: class {
    func seeDetail()
}

class BigFlashcardCollectionViewCell: SwipeCollectionViewCell {

    @IBOutlet weak var upLoadButton: UIView!
    @IBOutlet weak var uploadImageView: UIImageView!
    @IBOutlet weak var seeDetailButton: UIView!
    weak var actionDelegate: BigFlashcardDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        upLoadButton.layer.cornerRadius = upLoadButton.frame.height/2
        seeDetailButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(seeDetailAction)))
    }
    
    @objc func seeDetailAction() {
        actionDelegate?.seeDetail()
    }

}
