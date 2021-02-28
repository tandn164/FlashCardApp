//
//  MainTabBarController.swift
//  FlashCardApp
//
//  Created by Nguyễn Đức Tân on 9/5/20.
//  Copyright © 2020 Nguyễn Đức Tân. All rights reserved.
//

import UIKit

enum TabType {
    case home
    case dictionary
    
    var name: String {
        switch self {
        case .home:
            return Localizable.tabHome
        case .dictionary:
            return Localizable.tabUser
        }
    }
    
    var iconOn: UIImage? {
        switch self {
        case .home:
            return .tabHomeOn
        case .dictionary:
            return .tabUserOn
        }
    }
    
    var iconOff: UIImage? {
        switch self {
        case .home:
            return .tabHomeOff
        case .dictionary:
            return .tabUserOff
        }
    }
    
    var viewController: UIViewController {
        let vc: UIViewController
        
        switch self {
        case .home:
            vc = HomeViewController()
        case .dictionary:
            vc = DictionaryViewController()
        }
        
        vc.title = name
        return vc
    }
}

final class MainTabBarController: UITabBarController {
    
    private let mainTabBars: [TabType] = [.dictionary, .home]

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        setupView()
    }

    private func setupView() {
        let appearance = UITabBarItem.appearance()
        appearance.setTitleTextAttributes([.foregroundColor: .grayColor ?? UIColor.gray],
                                          for: .normal)
        appearance.setTitleTextAttributes([.foregroundColor: .primaryColor ?? UIColor.orange],
                                          for: .selected)
        appearance.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 12)],
                                          for: .normal)
        
        tabBar.barTintColor = .white
        tabBar.isTranslucent = false
        
        let viewControllers = mainTabBars.map { tab -> UIViewController in
            let tabBarItem = UITabBarItem(title: tab.name,
                                          image: tab.iconOff?.withRenderingMode(.alwaysOriginal),
                                          selectedImage: tab.iconOn?.withRenderingMode(.alwaysOriginal))
            
            let viewController = BaseNavigationController(rootViewController: tab.viewController)
            viewController.tabBarItem = tabBarItem
            return viewController
        }
        
        self.viewControllers = viewControllers
    }
}

extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    }
}
