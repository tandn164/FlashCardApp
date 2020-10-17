//
//  LoadingHud.swift
//  FlashCardApp
//
//  Created by Nguyễn Đức Tân on 10/15/20.
//  Copyright © 2020 Nguyễn Đức Tân. All rights reserved.
//

import Foundation
import UIKit

class SpinnerViewController: UIViewController {
    
    var spinner = UIActivityIndicatorView(style: .whiteLarge)
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)
        
        spinner.startAnimating()
        view.addSubview(spinner)
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

var loadingView: UIView = {
    let spinnerController = SpinnerViewController()
    spinnerController.view.frame = UIScreen.main.bounds
    return spinnerController.view
}()

struct LoadingHud {
    
    static func show() {
        UIApplication.shared.keyWindow?.addSubview(loadingView)
    }
    
    static func hide() {
        loadingView.removeFromSuperview()
    }
}
