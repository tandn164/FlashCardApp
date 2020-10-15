//
//  AppConfig.swift
//  FlashCardApp
//
//  Created by Nguyễn Đức Tân on 9/12/20.
//  Copyright © 2020 Nguyễn Đức Tân. All rights reserved.
//

import UIKit
import TwitterKit

struct AppConfig {
    
    static let developUrl = ""
    static let stagingUrl = ""
    
    static var baseUrl: String = {
        var string = developUrl
        #if !DEBUG
        string = stagingUrl
        #endif
        if ProcessInfo.processInfo.environment["staging"] == "on" {
            string = stagingUrl
        }
        return string
    }()
}

private struct TwitterAPI {
    static let key = "8bQakD7mLiHqh9GVAS4YRYMWd"
    static let secretKey = "8A2uY4E8JL5XEbMBEwGs7WUhqGCZ2oGvLgQFPxGqFC7Fj4lmhz"
}

class Twitter {
    static func configure() {
        TWTRTwitter.sharedInstance().start(withConsumerKey: TwitterAPI.key, consumerSecret: TwitterAPI.secretKey)
    }
}
