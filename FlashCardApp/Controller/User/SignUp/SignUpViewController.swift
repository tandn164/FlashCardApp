//
//  SignUpViewController.swift
//  FlashCardApp
//
//  Created by Nguyễn Đức Tân on 9/6/20.
//  Copyright © 2020 Nguyễn Đức Tân. All rights reserved.
//

import UIKit

class SignUpViewController: BaseViewController {
    
    @IBOutlet weak var functionView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isHiddenNavBar = true
        functionView.layer.cornerRadius = 20
        setGesture()
    }
}

extension SignUpViewController {
    
    func setGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
         if touch.view?.isDescendant(of: functionView) == true {
            return false
         }
         return true
    }
}
