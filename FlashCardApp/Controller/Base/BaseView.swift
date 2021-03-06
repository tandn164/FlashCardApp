//
//  BaseView.swift
//  FlashCardApp
//
//  Created by Nguyễn Đức Tân on 28/02/2021.
//  Copyright © 2021 Nguyễn Đức Tân. All rights reserved.
//

import UIKit

extension UIView {
    @objc public func forceConstraintToSuperView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        // Set constraint to self
        let top = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: self.superview, attribute: .top, multiplier: 1, constant: 0)
        let leading = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: self.superview, attribute: .leading, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: self.superview, attribute: .trailing, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: self.superview, attribute: .bottom, multiplier: 1, constant: 0)
        
        self.superview?.addConstraints([top, leading, trailing, bottom])
    }
    
    @IBInspectable var round: Bool {
        get {
            return self.bounds.width == self.bounds.height && cornerRadius == self.bounds.width / 2
        }
        set {
            if self.bounds.width == self.bounds.height {
                cornerRadius = self.bounds.width / 2
            }
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            //TODO fix me
            if let subLayers = layer.sublayers {
//                for subLayer in subLayers {
//                    subLayer.cornerRadius = layer.cornerRadius
//                    print(subLayer)
////                    layer.masksToBounds = newValue > 0
//                }

                // default shadow redius and offset
                if layer.shadowRadius == 3 && layer.shadowOffset.height == -3 {
                    layer.masksToBounds = newValue > 0
                }
            } else {
                layer.masksToBounds = newValue > 0
            }
        }
    }
    
    @IBInspectable var topCornersRadius: CGFloat {
        get {
            return 0.0   // Just to satisfy property
        }
        set {
            roundCorners(radius: newValue)
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var leftBorderWidth: CGFloat {
        get {
            return 0.0   // Just to satisfy property
        }
        set {
            let line = UIView(frame: CGRect(x: 0.0, y: 0.0, width: newValue, height: bounds.height))
            line.translatesAutoresizingMaskIntoConstraints = false
            line.backgroundColor = UIColor(cgColor: layer.borderColor!)
            self.addSubview(line)
            
            let views = ["line": line]
            let metrics = ["lineWidth": newValue]
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[line(==lineWidth)]", options: [], metrics: metrics, views: views))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[line]|", options: [], metrics: nil, views: views))
        }
    }
    
    @IBInspectable var topBorderWidth: CGFloat {
        get {
            return 0.0   // Just to satisfy property
        }
        set {
            let line = UIView(frame: CGRect(x: 0.0, y: 0.0, width: bounds.width, height: newValue))
            line.translatesAutoresizingMaskIntoConstraints = false
            line.backgroundColor = borderColor
            self.addSubview(line)
            
            let views = ["line": line]
            let metrics = ["lineWidth": newValue]
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[line]|", options: [], metrics: nil, views: views))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[line(==lineWidth)]", options: [], metrics: metrics, views: views))
        }
    }
    
    @IBInspectable var rightBorderWidth: CGFloat {
        get {
            return 0.0   // Just to satisfy property
        }
        set {
            let line = UIView(frame: CGRect(x: bounds.width, y: 0.0, width: newValue, height: bounds.height))
            line.translatesAutoresizingMaskIntoConstraints = false
            line.backgroundColor = borderColor
            self.addSubview(line)
            
            let views = ["line": line]
            let metrics = ["lineWidth": newValue]
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "[line(==lineWidth)]|", options: [], metrics: metrics, views: views))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[line]|", options: [], metrics: nil, views: views))
        }
    }
    @IBInspectable var bottomBorderWidth: CGFloat {
        get {
            return 0.0   // Just to satisfy property
        }
        set {
            let line = UIView(frame: CGRect(x: 0.0, y: bounds.height, width: bounds.width, height: newValue))
            line.translatesAutoresizingMaskIntoConstraints = false
            line.backgroundColor = borderColor
            self.addSubview(line)
            
            let views = ["line": line]
            let metrics = ["lineWidth": newValue]
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[line]|", options: [], metrics: nil, views: views))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[line(==lineWidth)]|", options: [], metrics: metrics, views: views))
        }
    }

    @IBInspectable var shadowColor: UIColor {
        get {
            return self.layer.shadowColor != nil ? UIColor(cgColor: self.layer.shadowColor!) : UIColor.clear
        }
        set {
            var red : CGFloat = 0
            var green : CGFloat = 0
            var blue : CGFloat = 0
            var alpha: CGFloat = 0
            newValue.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            let color = UIColor(red: red, green: green, blue: blue, alpha: 1)
            self.layer.shadowColor = color.cgColor
            self.layer.shadowOpacity = Float(alpha)
        }
    }
    
//    @IBInspectable var shadowOpacity: Float {
//        get {
//            return self.layer.shadowOpacity
//        }
//        set {
//            self.layer.shadowOpacity = newValue
//        }
//    }
    
    @IBInspectable var shadowOffset: CGSize {
        get{
            return self.layer.shadowOffset
        }
        set {
            self.layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    func roundCorners(radius: CGFloat) {
         if #available(iOS 11.0, *){
             self.clipsToBounds = true
             self.layer.cornerRadius = radius
             self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
         }else{
             let rectShape = CAShapeLayer()
             rectShape.bounds = self.frame
             rectShape.position = self.center
             rectShape.path = UIBezierPath(roundedRect: self.bounds,    byRoundingCorners: [.topLeft , .topRight], cornerRadii: CGSize(width: radius, height: radius)).cgPath
             self.layer.mask = rectShape
         }
    }
    
    func setTransformRotation(toDegrees angleInDegrees: CGFloat) {
        let angleInRadians = angleInDegrees / 180.0 * CGFloat.pi
        let rotation = self.transform.rotated(by: angleInRadians)
        self.transform = rotation
    }
}

extension UIWindow {
    
    /// Fix for http://stackoverflow.com/a/27153956/849645
    func set(rootViewController newRootViewController: UIViewController, withTransition transition: CATransition? = nil) {
        
        let previousViewController = rootViewController
        
        if let transition = transition {
            // Add the transition
            layer.add(transition, forKey: kCATransition)
        }
        
        rootViewController = newRootViewController
        
        // Update status bar appearance using the new view controllers appearance - animate if needed
        if UIView.areAnimationsEnabled {
            UIView.animate(withDuration: CATransaction.animationDuration()) {
                newRootViewController.setNeedsStatusBarAppearanceUpdate()
            }
        } else {
            newRootViewController.setNeedsStatusBarAppearanceUpdate()
        }
        
        /// The presenting view controllers view doesn't get removed from the window as its currently transistioning and presenting a view controller
        if let transitionViewClass = NSClassFromString("UITransitionView") {
            for subview in subviews where subview.isKind(of: transitionViewClass) {
                subview.removeFromSuperview()
            }
        }
        if let previousViewController = previousViewController {
            // Allow the view controller to be deallocated
            previousViewController.dismiss(animated: false) {
                // Remove the root view in case its still showing
                previousViewController.view.removeFromSuperview()
            }
        }
    }
}
