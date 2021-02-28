//
//  AppConstant.swift
//  FlashCardApp
//
//  Created by Nguyễn Đức Tân on 27/02/2021.
//  Copyright © 2021 Nguyễn Đức Tân. All rights reserved.
//

import Foundation
import UIKit

class AppConstant {
    
    static var appVersion: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    }
    
    static var appBuild: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
    }

    static var appIdentifier: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleIdentifier") as! String
    }
    
    enum Language: String {
        case EN = "en"
        case JA = "ja"
    }
    
    enum SystemGenre: String {
        case N1 = "JLPT N1"
        case N2 = "JLPT N2"
        case N3 = "JLPT N3"
        case N4 = "JLPT N4"
        case N5 = "JLPT N5"
    }
    
    enum AuthError: Int {
        case noError = 0
        case noUser
        case mailVerify
    }
    
}
