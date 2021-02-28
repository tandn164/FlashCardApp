//
//  UIAlertViewController+Extension.swift
//  FlashCardApp
//
//  Created by Nguyễn Đức Tân on 9/6/20.
//  Copyright © 2020 Nguyễn Đức Tân. All rights reserved.
//

import UIKit

typealias SystemAlertButtonData = (title: String, style: UIAlertAction.Style, handler: (() -> Void)?)

extension UIAlertController {
    
    static func showError(message: String? = nil, tittle: String = "Error") {
        show(message: message, title: tittle)
    }
    
    static func showAlert(message: String) {
        show(message: message, title: "")
    }
    
    static private func show(message: String? = nil, title: String? = nil) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        UIViewController.top()?.present(alertController, animated: true)
    }
    
    static func showSystemAlert(target: UIViewController? = UIViewController.top(),
                                title: String? = nil,
                                message: String? = nil,
                                buttons: [String],
                                buttonStyles: [UIAlertAction.Style?] = [],
                                handler: ((_ index: Int, _ title: String) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        buttons.enumerated().forEach { button in
            var buttonStyle: UIAlertAction.Style = .default
            if button.offset < buttonStyles.count, let style = buttonStyles[button.offset] {
                buttonStyle = style
            }
            
            let action = UIAlertAction(title: button.element, style: buttonStyle, handler: { _ in
                handler?(button.offset, button.element)
            })
            alert.addAction(action)
        }
        target?.present(alert, animated: true)
    }
    
    static func showActionSheets(target: UIViewController? = UIViewController.top(),
                                 title: String? = nil,
                                 message: String? = nil,
                                 buttons: [String],
                                 buttonStyles: [UIAlertAction.Style?] = [],
                                 buttonColors: [UIColor?] = [],
                                 handler: ((_ index: Int, _ title: String) -> Void)? = nil) {
        
        let actions = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        buttons.enumerated().forEach { button in
            var buttonStyle: UIAlertAction.Style = .default
            var buttonColor: UIColor = .systemBlue
            if button.offset < buttonStyles.count, let style = buttonStyles[button.offset] {
                buttonStyle = style
            }
            if button.offset < buttonColors.count, let color = buttonColors[button.offset] {
                buttonColor = color
            }
            let action = UIAlertAction(title: button.element, style: buttonStyle, handler: { _ in
                handler?(button.offset, button.element)
            })
            action.setValue(buttonColor, forKey: "titleTextColor")
            actions.addAction(action)
        }
        target?.present(actions, animated: true)
    }
}

