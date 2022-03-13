//
//  ContentsTableViewController.swift
//  EYNTA
//
//  Created by James Slusser on 1/15/19.
//  Copyright © 2019 James Slusser. All rights reserved.
//

import UIKit
import SwiftUI

class ContentsTableViewController: UITableViewController {

    var items: [Item] = Item.allCases
    
    enum Item: CaseIterable {
        case ch1
        case ch2
        case ch3
        case ch4
        case ch5
        case ch6
        case ch7
        case ch8
        case ch9
        case ch10
        case ch11
        case ch12
        case ch13
        case ch14
        case ch15
        case ch16
        case ch17
        case ch18
        case titlePage
       
        var title: String {
            switch self {
            case .ch1: return NSLocalizedString("Chapter 1 - Introduction", comment: "Add comment here")
            case .ch2: return NSLocalizedString("Chapter 2 - In Other Words", comment: "Add comment here")
            case .ch3: return NSLocalizedString("Chapter 3 - Before You Go", comment: "Add comment here")
            case .ch4: return NSLocalizedString("Chapter 4 - General Aspects of Community", comment: "Add comment here")
            case .ch5: return NSLocalizedString("Chapter 5 - Licenses & Administration", comment: "Add comment here")
            case .ch6: return NSLocalizedString("Chapter 6 - Contract", comment: "Add comment here")
            case .ch7: return NSLocalizedString("Chapter 7 - Observations/Tour", comment: "Add comment here")
            case .ch8: return NSLocalizedString("Chapter 8 - Accommodations", comment: "Add comment here")
            case .ch9: return NSLocalizedString("Chapter 9 - Medical and Nursing", comment: "Add comment here")
            case .ch10: return NSLocalizedString("Chapter 10 - Food Services", comment: "Add comment here")
            case .ch11: return NSLocalizedString("Chapter 11 - Activities", comment: "Add comment here")
            case .ch12: return NSLocalizedString("Chapter 12 - Housekeeping & Maintenance", comment: "Add comment here")
            case .ch13: return NSLocalizedString("Chapter 13 - Transportation", comment: "Add comment here")
            case .ch14: return NSLocalizedString("Chapter 14 - Emergency Plan & Safety", comment: "Add comment here")
            case .ch15: return NSLocalizedString("Chapter 15 - LGBTQ and Assisted Living Communities", comment: "Add comment here")
            case .ch16: return NSLocalizedString("Chapter 16 - Acronyms and Vocabulary", comment: "Add comment here")
            case .ch17: return NSLocalizedString("Chapter 17 - About the Authors", comment: "Add comment here")
            case .ch18: return NSLocalizedString("Chapter 18 - Helpful Resources", comment: "Add comment here")
            case .titlePage: return NSLocalizedString("Book Cover Title Page", comment: "Add comment here")
            }
        }
        
        var chapterNumber: ChapterNumber? {
            switch self {
            case .ch4: return .ch4
            case .ch5: return .ch5
            case .ch6: return .ch6
            case .ch7: return .ch7
            case .ch8: return .ch8
            case .ch9: return .ch9
            case .ch10: return .ch10
            case .ch11: return .ch11
            case .ch12: return .ch12
            case .ch13: return .ch13
            case .ch14: return .ch14
            case .ch15: return .ch15
            default: return nil
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        //navigationItem.title = "Table of Contents"
        navigationItem.title = NSLocalizedString("Table of Contents", comment: "Add comment here")
        
        setupTableView()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func setupTableView() {
        tableView.backgroundColor = .systemBlue
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.estimatedRowHeight = 40
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel?.text = item.title
        cell.textLabel?.textColor = .white
        cell.contentView.backgroundColor = .systemBlue
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        let newVC = viewControllerToPresent(for: item)
        newVC.view.backgroundColor = .systemBackground
        newVC.navigationItem.title = item.title
        navigationController?.pushViewController(newVC, animated: true)
    }
    
    func viewControllerToPresent(for item: Item) -> UIViewController {
        switch item {
        case .ch1, .ch2, .ch3, .ch4, .ch5, .ch6, .ch7, .ch8, .ch9, .ch10, .ch11, .ch12, .ch13, .ch14, .ch15, .ch17:
            let newVC = ChapterViewController(dataContent: item.dataContent,
                                              chapterNumber: item.chapterNumber)
            return newVC
            
        case .ch16:
            return VocabularyTableViewController()
       
        case .ch18:
            return HelpfulResourcesViewController(text: item.chapterText)
            
        case .titlePage:
            return BookCoverViewController(imageName: "Cover")
           
        }
        
    }
}
