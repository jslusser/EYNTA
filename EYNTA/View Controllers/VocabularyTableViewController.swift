//
//  VocabularyTableViewController.swift
//  EYNTA
//
//  Created by James Slusser on 2/3/19.
//  Copyright © 2019 James Slusser. All rights reserved.
//


//New attempt Apr 08, 2010
import UIKit

class VocabularyTableViewController: UITableViewController {
    var terms = [Vocabulary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        tableView.register(GlossaryTableViewCell.self, forCellReuseIdentifier: GlossaryTableViewCell.reuseId)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        guard let url = Bundle.main.url(forResource: "chx15Glossary", withExtension: "json"),
            let ch15JSONData = try? Data(contentsOf: url),
            let ch15terms = try? JSONDecoder().decode(Array<Vocabulary>.self, from: ch15JSONData) else {
                print("Error loading JSON")
                fatalError()
        }
        print(ch15terms)
        self.terms = ch15terms
//        tableView.register(GlossaryTableViewCell.self, forCellReuseIdentifier: GlossaryTableViewCell.reuseId)
        tableView.estimatedRowHeight = 50
    }
 //   MARK: - Table view data source
//    deleted override
   override func numberOfSections(in tableView: UITableView) -> Int {
//        #warning Incomplete implementation, return the number of sections
       return 1
   }

 //   deleted override
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        #warning Incomplete implementation, return the number of rows
       return self.terms.count
       
   }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

      guard let cell = tableView.dequeueReusableCell(withIdentifier: GlossaryTableViewCell.reuseId) as? GlossaryTableViewCell else { return UITableViewCell() }

      let term = terms[indexPath.row]
      cell.configure(term: term)
      return cell
}

// MARK: - Table view data source

//override func numberOfSections(in tableView: UITableView) -> Int {
//    // #warning Incomplete implementation, return the number of sections
//    return 1
//}
//
//override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    // #warning Incomplete implementation, return the number of rows
//    return 65
//    }
//}
// var myDictionary = ["key":"data", term:definition]
// How do I (or can I) decode my chx15Glossary.json file and assign the term into the key, and the definition into the data?  Do I need to loop thru something to easily assign this?  I'm sooooooooo confused.
//And then what do I do?  I think I want a simple tableview controller with one term on each row, and then when the user touches the row (the term), then show the definition.  Not sure what




// Original/old code below (but it neer worked.  Just keeping it seperate from current experimentation)
/*
import UIKit

class VocabularyTableViewController: UITableViewController, CellProtocol {
    func switchButtonTapped(WithStatus status: Bool, ForCell myCell: QuestionsTableViewCell) {
        <#code#>
    }
    
    
    var terms = [Vocabulary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        guard let url = Bundle.main.url(forResource: "chx15Glossary", withExtension: "json"),
            let ch15JSONData = try? Data(contentsOf: url),
            let ch15terms = try? JSONDecoder().decode(Array<Vocabulary>.self, from: ch15JSONData) else {
                print("Error loading JSON")
                fatalError()
        }
        print(ch15terms)
        self.terms = ch15terms
        let questionsNib = UINib(nibName: "VocabularyTableViewCell", bundle: nil)
        tableView.register(questionsNib, forCellReuseIdentifier: "VocabularyTableViewCell")
        tableView.estimatedRowHeight = 50
    }
    
    
}





*/
}
