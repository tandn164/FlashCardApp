//
//  AppPreferences.swift
//  FlashCardApp
//
//  Created by Nguyễn Đức Tân on 27/02/2021.
//  Copyright © 2021 Nguyễn Đức Tân. All rights reserved.
//

import Foundation

class AppPreferences {
    private let kLatestVersion = "kLatestVersion"
    private let kCurrentLocale = "kCurrentLocale"

    static let _instance = AppPreferences()

    static var instance: AppPreferences {
        get {
            return _instance
        }
    }

    private init() {
        UserDefaults.standard.register(defaults: [
            kCurrentLocale : "en"
        ])
    }

    var lastestVersion: Int {
        set {
            UserDefaults.standard.set(newValue, forKey: kLatestVersion)
        }
        get {
            return UserDefaults.standard.integer(forKey: kLatestVersion)
        }
    }
    
    var language: AppConstant.Language.RawValue {
        set {
            UserDefaults.standard.set(newValue, forKey: kCurrentLocale)
        }
        get {
            return UserDefaults.standard.string(forKey: kCurrentLocale) ?? "en"
        }
    }
}
