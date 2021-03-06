//
//  WordModel.swift
//  FlashCardApp
//
//  Created by Nguyễn Đức Tân on 07/03/2021.
//  Copyright © 2021 Nguyễn Đức Tân. All rights reserved.
//

import Foundation

class WordModel: NSObject, NSCoding, Decodable {
    var id: Int?
    var word: String?
    var meaning: String?
    var learned: Int?
    
    init(id: Int?,
         word: String?,
         meaning: String?,
         learned: Int?) {
        self.id = id
        self.word = word
        self.meaning = meaning
        self.learned = learned
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeInteger(forKey: "id")
        let word = aDecoder.decodeObject(forKey: "word") as? String
        let meaning = aDecoder.decodeObject(forKey: "meaning") as? String
        let learned = aDecoder.decodeInteger(forKey: "learned")
        self.init(id: id,
                  word: word,
                  meaning: meaning,
                  learned: learned)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(word, forKey: "word")
        aCoder.encode(meaning, forKey: "meaning")
        aCoder.encode(learned, forKey: "learned")
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case word
        case meaning
        case learned
    }
}
