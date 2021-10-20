//
//  Questions.swift
//  EYNTA
//
//  Created by James Slusser on 1/31/19.
//  Copyright © 2019 James Slusser. All rights reserved.
//

import Foundation

enum ChapterNumber: String, Codable {
    case ch4, ch5, ch6, ch7, ch8, ch9, ch10, ch11, ch12, ch13, ch14, ch15
    
    var displayCh: String {
        switch self {
        case .ch4: return "Ch 4"
        case .ch5: return "Ch 5"
        case .ch6: return "Ch 6"
        case .ch7: return "Ch 7"
        case .ch8: return "Ch 8"
        case .ch9: return "Ch 9"
        case .ch10: return "Ch 10"
        case .ch11: return "Ch 11"
        case .ch12: return "Ch 12"
        case .ch13: return "Ch 13"
        case .ch14: return "Ch 14"
        case .ch15: return "Ch 15"
        }
    }
}

struct Question : Codable, Equatable, Hashable {
    let questionNumber: Int
    let questionCopy: String
    let chapter: ChapterNumber
    var isSelected: Bool
    var userAnswer: String
    
    enum CodingKeys: String, CodingKey {
        case questionNumber = "questionNumber"
        case questionCopy = "questionCopy"
        case chapter = "chapter"
        case isSelected = "isSelected"
        case userAnswer = "userAnswer"
    }
    
    // TODO: Fix this and make more correctly:
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
    
        questionNumber = try container.decode(Int.self, forKey: .questionNumber)
        questionCopy = try container.decode(String.self, forKey: .questionCopy)
        chapter = try container.decode(ChapterNumber.self, forKey: .chapter)
        isSelected = try container.decode(Bool.self, forKey: .isSelected)
        if let theAnswer: String = try? container.decode(String.self, forKey: .userAnswer) {
            userAnswer = theAnswer
        } else {
            userAnswer = ""
        }
        
        
    }
}

struct Vocabulary : Codable {
    let termNumber: Int
    let term: String
    let definition: String
    let chapter: ChapterNumber
}

