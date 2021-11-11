//
//  ItemExtension.swift
//  EYNTA
//
//  Created by James Slusser on 11/3/21.
//  Copyright © 2021 James Slusser. All rights reserved.
//

import UIKit

extension ContentsTableViewController.Item {
    var dataContent: [PageContent] {
        switch self {
        case .ch1: return [.text(ChapterText.chapter1Text)]
        case .ch2: return [.text(ChapterText.chapter2Text)]
        case .ch3: return [.text(ChapterText.chapter3Text)]
        case .ch4: return ChapterDataContent.chapter4Content
        case .ch5: return ChapterDataContent.chapter5Content
        case .ch6: return ChapterDataContent.chapter6Content
        case .ch7: return ChapterDataContent.chapter7Content
        case .ch8: return ChapterDataContent.chapter8Content
        case .ch9: return [.text(ChapterText.chapter9Text)]
        case .ch10: return [.text(ChapterText.chapter10Text)]
        case .ch11: return [.text(ChapterText.chapter11Text)]
        case .ch12: return [.text(ChapterText.chapter12Text)]
        case .ch13: return [.text(ChapterText.chapter13Text)]
        case .ch14: return [.text(ChapterText.chapter14Text)]
        case .ch15: return [.text(ChapterText.chapter15Text)]
        case .ch16: return [.text("You need to handle this differently")]
        case .ch17: return [.text(ChapterText.chapter17Text)]
        case .ch18: return [.text(ChapterText.chapter18Text)]
        case .titlePage: return [.text("This needs the image. Use a different VC")]
        }
    }
    
    var chapterText: String {
        let movedToDataContentMessage = "Moved To Data Content"
        switch self {
        case .ch1: return ChapterText.chapter1Text
        case .ch2: return ChapterText.chapter2Text
        case .ch3: return ChapterText.chapter3Text
        case .ch4: return movedToDataContentMessage
        case .ch5: return ChapterText.chapter5Text
        case .ch6: return ChapterText.chapter6Text
        case .ch7: return ChapterText.chapter7Text
        case .ch8: return ChapterText.chapter8Text
        case .ch9: return ChapterText.chapter9Text
        case .ch10: return ChapterText.chapter10Text
        case .ch11: return ChapterText.chapter11Text
        case .ch12: return ChapterText.chapter12Text
        case .ch13: return ChapterText.chapter13Text
        case .ch14: return ChapterText.chapter14Text
        case .ch15: return ChapterText.chapter15Text
        case .ch16: return "You need to handle this differently"
        case .ch17: return ChapterText.chapter17Text
        case .ch18: return ChapterText.chapter18Text
        case .titlePage: return "This needs the image. Use a different VC"
        }
    }
    
    var chapterImage: UIImage? {
        switch self {
        case .ch2: return UIImage(named: "IOW")
        default: return nil
        }
    }
}

extension UIImage {
    static var iow: UIImage? {
        return UIImage(named: "IOW")
    }
}

enum PageContent {
    case text(String)
    case image(UIImage?)
    case customText(NSMutableAttributedString)
}
