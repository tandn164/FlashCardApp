//
//  HomeHeaderView.swift
//  FlashCardApp
//
//  Created by Nguyễn Đức Tân on 28/02/2021.
//  Copyright © 2021 Nguyễn Đức Tân. All rights reserved.
//

import UIKit

class HomeHeaderView: UIView {

    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var homeView: UIView!
    @IBOutlet weak var listView: MenuView!
    @IBOutlet weak var listViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet var contentView: UIView!
    var menuIsShown = false
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        initSubviews()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    func initSubviews() {
        let nib = UINib(nibName: "HomeHeaderView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
        
        contentView.forceConstraintToSuperView()
        menuView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showMenu)))
    }
    
    @objc func showMenu() {
        if !menuIsShown {
            listViewTrailingConstraint.constant = 10
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           options: [],
                           animations: { [weak self] in
                            self?.contentView.layoutIfNeeded()
                            self?.menuIsShown = true
              }, completion: nil)
        } else {
            listViewTrailingConstraint.constant = -170
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           options: [],
                           animations: { [weak self] in
                            self?.contentView.layoutIfNeeded()
                            self?.menuIsShown = false
              }, completion: nil)
        }
    }
}
