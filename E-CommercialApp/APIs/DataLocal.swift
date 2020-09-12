//
//  DataLocal.swift
//  E-CommercialApp
//
//  Created by Nguyễn Đức Tân on 9/12/20.
//  Copyright © 2020 Nguyễn Đức Tân. All rights reserved.
//

import Foundation

class DataLocal: NSObject {
    class func saveObject(_ value: Any?, forKey defaultName: String) {
        UserDefaults.standard.set(value, forKey: defaultName)
    }
        
    class func getObject(_ key: String) -> Any? {
        return UserDefaults.standard.object(forKey: key)
    }
    
    class func removeObject(_ key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
