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
}

struct Question : Codable, Equatable, Hashable {
    let questionNumber: Int
    let questionCopy: String
    let chapter: ChapterNumber
    var isSelected: Bool
    
    // TODO: Fix this and make more correctly: 
}

struct Vocabulary : Codable {
    let termNumber: Int
    let term: String
    let definition: String
    let chapter: ChapterNumber
}

