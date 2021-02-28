//
//  String+Extension.swift
//  FlashCardApp
//
//  Created by Nguyễn Đức Tân on 10/15/20.
//  Copyright © 2020 Nguyễn Đức Tân. All rights reserved.
//

import UIKit

extension String {
    
    func setTextColor(color: UIColor) -> NSAttributedString {
        let str: NSString = self as NSString
        let range = str.range(of: self)
        let attribute = NSMutableAttributedString.init(string: self)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor,
                               value: color,
                               range: range)
        return attribute
    }
    
    var toInt: Int? {
        return Int(self)
    }
    
    var toUrl: URL? {
        if let url = URL(string: self) {
            return url
        } else {
            guard let string = addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) else {
                return nil
            }
            return URL(string: string)
        }
    }
    
    var toNumber: NSNumber? {
        if let number = Int(self) {
            return NSNumber(value: number)
        }
        return nil
    }
    
    func attributedStringWithColor(_ strings: [String],
                                   color: UIColor,
                                   font: UIFont,
                                   characterSpacing: UInt? = nil) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        for string in strings {
            let range = (self as NSString).range(of: string)
            attributedString.addAttributes([NSAttributedString.Key.foregroundColor : color,
                                            NSAttributedString.Key.font : font], range: range)
        }
        
        guard let characterSpacing = characterSpacing else {return attributedString}
        
        attributedString.addAttribute(NSAttributedString.Key.kern,
                                      value: characterSpacing,
                                      range: NSRange(location: 0, length: attributedString.length))
        
        return attributedString
    }
    
    func subStringByString(_ string: String) -> String? {
        guard let endIndex = self.range(of: string)?.lowerBound else {
            return nil
        }
        return String(self[..<endIndex])
    }
    
    var shortDate: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = .autoupdatingCurrent
        guard let date = dateFormatter.date(from: self) else { return nil }
        
        let dateComponents = Calendar.current.dateComponents([.month, .day],
                                                             from: date)
        
        return String(format: "%d月%d日 配信",
                      dateComponents.month ?? 0, dateComponents.day ?? 0)
    }
    
    public var localized: String {
        let currentLocale = AppPreferences.instance.language
        guard
            let bundlePath = Bundle.main.path(forResource: currentLocale, ofType: "lproj"),
            let bundle = Bundle(path: bundlePath) else {
            return self
        }
        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")    }
    
    public var localizedLowercase: String {
        return self.localized.lowercased()
    }
    
    public var localizedUppercase: String {
        return self.localized.uppercased()
    }
}

extension Int {
    var toString: String {
        return String(self)
    }
}
