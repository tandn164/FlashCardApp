//
//  AccountManager.swift
//  FlashCardApp
//
//  Created by Nguyễn Đức Tân on 9/12/20.
//  Copyright © 2020 Nguyễn Đức Tân. All rights reserved.
//

import UIKit

struct AccountManager {
    
    static var token: String? {
        return DataLocal.getObject(AppKey.token) as? String
    }
}

