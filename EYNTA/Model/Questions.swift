//
//  Questions.swift
//  EYNTA
//
//  Created by James Slusser on 1/31/19.
//  Copyright © 2019 James Slusser. All rights reserved.
//

import Foundation

struct Question : Codable {
    let questionCopy: String
    let chapter: chapterNumber
    enum chapterNumber: String, Codable {
        case ch4, ch5, ch6, ch7, ch8, ch9, ch10, ch11, ch12, ch13, ch14
    }
}
