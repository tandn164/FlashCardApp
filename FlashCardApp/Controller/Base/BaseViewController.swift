//
//  BaseViewController.swift
//  FlashCardApp
//
//  Created by Nguyễn Đức Tân on 9/6/20.
//  Copyright © 2020 Nguyễn Đức Tân. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    let backButton = UIButton(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBackBarButton()
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    deinit {
        navigationController?.delegate = nil
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
     }
    
    func addBackBarButton() {
        if let nav = navigationController, nav.viewControllers.count > 1 {
            backButton.setImage(.icBack, for: .normal)
            backButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -24, bottom: 0, right: 0)
            backButton.addTarget(self, action: #selector(onBack), for: .touchUpInside)
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        }
    }
    
    func addCloseBarButton(_ tintColor: UIColor = .black) {
        if presentingViewController != nil {
            let closeButton = UIButton(type: .custom)
            closeButton.setImage(.icClose, for: .normal)
            closeButton.addTarget(self, action: #selector(onClose), for: .touchUpInside)
            closeButton.tintColor = tintColor
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: closeButton)
        }
    }
    
    @objc func onBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func onClose() {
        dismiss(animated: true)
    }
    
    func clearNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.backgroundColor = UIColor.clear
    }
}

extension BaseViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

