//
//  Result.swift
//  FlashCardApp
//
//  Created by Nguyễn Đức Tân on 9/12/20.
//  Copyright © 2020 Nguyễn Đức Tân. All rights reserved.
//

import Foundation

struct Result: Decodable {
    let success: Bool?
    let error: ErrorApi?
    let message: String?
    
    enum CodingKeys: String, CodingKey {
        case success
        case error
        case message
    }
    
}

struct ErrorApi: Decodable {
    var code: String?
    var message: String?
    
    enum CondingKeys: String, CodingKey {
        case code
        case message
    }
}
