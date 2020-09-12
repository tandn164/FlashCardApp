//
//  AppConfig.swift
//  E-CommercialApp
//
//  Created by Nguyễn Đức Tân on 9/5/20.
//  Copyright © 2020 Nguyễn Đức Tân. All rights reserved.
//

import UIKit

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
