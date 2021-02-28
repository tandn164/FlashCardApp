//
//  BaseViewController.swift
//  FlashCardApp
//
//  Created by Nguyễn Đức Tân on 9/6/20.
//  Copyright © 2020 Nguyễn Đức Tân. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    @IBOutlet weak var appHeader: HomeHeaderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAction()
    }
    
    public func setTitleHeader(title: String) {
        if(appHeader != nil) {
            appHeader.title.text = title
            appHeader.listView.delegate = self
        }
    }
    
    private func setAction() {
        guard appHeader != nil else {
            return
        }
        appHeader.homeView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                       action: #selector(showRootViewController)))
        
    }
    
    @objc func onBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func onClose() {
        dismiss(animated: true)
    }
    
    @objc func showRootViewController() {
        
    }
}


extension BaseViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension BaseViewController: MenuViewDelegate {
    func logout() {
        logoutUser()
    }
    
    func editProfile() {
        editProfileUser()
    }
    
    @objc func logoutUser() {
    }
    
    @objc func editProfileUser() {
    }
}
