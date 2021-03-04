//
//  GenreModel.swift
//  FlashCardApp
//
//  Created by Nguyễn Đức Tân on 04/03/2021.
//  Copyright © 2021 Nguyễn Đức Tân. All rights reserved.
//

import Foundation

class GenreModel: NSObject, NSCoding, Decodable {
    var id: Int?
    var title: String?
    var flashCards: [FlashCardModel]?
    
    init(id: Int?,
         title: String?,
         flashCards: [FlashCardModel]?) {
        self.id = id
        self.title = title
        self.flashCards = flashCards
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeInteger(forKey: "id")
        let title = aDecoder.decodeObject(forKey: "title") as? String
        let flashCards = aDecoder.decodeObject(forKey: "flashCards") as? [FlashCardModel]
        self.init(id: id,
                  title: title,
                  flashCards: flashCards)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(title, forKey: "title")
        aCoder.encode(flashCards, forKey: "flashCards")
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case flashCards
    }
}
