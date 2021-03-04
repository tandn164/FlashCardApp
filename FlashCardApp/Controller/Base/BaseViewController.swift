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
    let listView = MenuView()
    var menuIsShown = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setHeader()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    public func setTitleHeader(title: String) {
        if(appHeader != nil) {
            appHeader.title.text = title
        }
    }
    
    private func setHeader() {
        guard appHeader != nil else {
            return
        }
        appHeader.homeView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                       action: #selector(showRootViewController)))
        addMenuItem()
    }
    
    private func addMenuItem() {
        view.addSubview(listView)
        listView.frame = CGRect(x: DeviceInfo.width,
                                y: appHeader.frame.maxY+appHeader.frame.height - 10,
                                width: 160,
                                height: 80)
        appHeader.menuView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showMenu)))
        listView.addShadow()
        listView.delegate = self
    }
    
    @objc func onBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func onClose() {
        dismiss(animated: true)
    }
    
    @objc func showRootViewController() {
        popToRoot()
    }
    
    @objc func showMenu() {
        if !menuIsShown {
            listView.frame = CGRect(x: DeviceInfo.width-170,
                                    y: appHeader.frame.minY + appHeader.frame.height - 10,
                                    width: 160,
                                    height: 80)
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           options: [],
                           animations: { [weak self] in
                            self?.view.layoutIfNeeded()
                            self?.menuIsShown = true
              }, completion: nil)
        } else {
            listView.frame = CGRect(x: DeviceInfo.width,
                                    y: appHeader.frame.minY + appHeader.frame.height - 10,
                                    width: 160,
                                    height: 80)
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           options: [],
                           animations: { [weak self] in
                            self?.view.layoutIfNeeded()
                            self?.menuIsShown = false
              }, completion: nil)
        }
    }
}


extension BaseViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension BaseViewController: MenuViewDelegate {
    func logout() {
        showMenu()
        logoutUser()
    }
    
    func editProfile() {
        editProfileUser()
        showMenu()
    }
    
    @objc func logoutUser() {
    }
    
    @objc func editProfileUser() {
    }
}
