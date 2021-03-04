//
//  FlashCardModel.swift
//  FlashCardApp
//
//  Created by Nguyễn Đức Tân on 04/03/2021.
//  Copyright © 2021 Nguyễn Đức Tân. All rights reserved.
//

import Foundation

class FlashCardModel: NSObject, NSCoding, Decodable {
    var id: Int?
    var title: String?
    var totalWords: Int?
    var learnedWords: Int?
    
    init(id: Int?,
         title: String?,
         totalWords: Int?,
         learnedWords: Int?) {
        self.id = id
        self.title = title
        self.totalWords = totalWords
        self.learnedWords = learnedWords
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeInteger(forKey: "id")
        let title = aDecoder.decodeObject(forKey: "title") as? String
        let totalWords = aDecoder.decodeInteger(forKey: "totalWords")
        let learnedWords = aDecoder.decodeInteger(forKey: "learnedWords")
        self.init(id: id,
                  title: title,
                  totalWords: totalWords,
                  learnedWords: learnedWords)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(title, forKey: "title")
        aCoder.encode(totalWords, forKey: "totalWords")
        aCoder.encode(learnedWords, forKey: "learnedWords")
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case totalWords
        case learnedWords
    }
}
