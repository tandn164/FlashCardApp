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
    var isClearNavigationBar = false
    var isHiddenNavBar = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBackBarButton()
    }
    
    deinit {
        navigationController?.delegate = nil
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        if isClearNavigationBar {
            clearNavigationBar()
        } else {
            navigationController?.navigationBar.shadowImage = UIColor.grayBackground?.image()
            navigationController?.navigationBar.setBackgroundImage(UIColor.grayBackground?.image(), for: .default)
            navigationController?.navigationBar.isTranslucent = false
        }
        navigationController?.setNavigationBarHidden(isHiddenNavBar, animated: true)
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
    
    // MARK: - Create fake navigation bar
    
    let navItem = UINavigationItem(title: "")
    
    var statusView = UIView(frame: CGRect(x: 0,
                                          y: 0,
                                          width: DeviceInfo.width,
                                          height: DeviceInfo.statusBarHeight))
    
    var fakeNavBar = UINavigationBar(frame: CGRect(x: 0,
                                                   y: DeviceInfo.statusBarHeight,
                                                   width: DeviceInfo.width,
                                                   height: 44))
    
    func addFakeNavigationBar() {
        
        statusView.backgroundColor = UIColor.grayBackground
        fakeNavBar.setItems([navItem], animated: false)
        fakeNavBar.shadowImage = UIColor.grayBackground?.image()
        fakeNavBar.setBackgroundImage(UIImage(),
                                      for: .default)
        fakeNavBar.backgroundColor = UIColor.grayBackground
        view.addSubview(fakeNavBar)
        view.addSubview(statusView)
    }
}

extension BaseViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

