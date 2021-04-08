//
//  Q9TableViewController.swift
//  EYNTA
//
//  Created by James Slusser on 11/16/19.
//  Copyright © 2019 James Slusser. All rights reserved.
//

import UIKit

class Q9TableViewController: UITableViewController, CellProtocol {

  
    
    // MARK: This question array is for the tableView data
    var questions = [Question]()
    
    func switchButtonTapped(WithStatus status: Bool, ForCell myCell: QuestionsTableViewCell) {
        // using guard let syntax to unwrap the optional; if it returns nil then it exits the function and does nothing
        guard let indexPath = self.tableView.indexPath(for: myCell) else { return }
        print("cell at indexpath \(String(describing: indexPath)) tapped with switch status \(status)")
        let ch9SwitchSelected = myCell.questionLabel.text!
        print("Question added/removed was \(String(describing: ch9SwitchSelected))")
        // MARK: - This code block adds or removes selected ingredients based on the status of the switch.
        
        questions[indexPath.row].isSelected = status
        if status {
            QuestionStorage.shared.saveSelectedQuestion(question: questions[indexPath.row])
        } else {
            // MARK: - This logic is here in the event that a given ingredient isn't in the selected ingredients array
            QuestionStorage.shared.removeSelectedQuestion(question: questions[indexPath.row])
        }
    }
    
    func checkForSavedSelectedQuestions() {
        let savedQuestions = QuestionStorage.shared.getSelectedQuestions(by: .ch9)
        
        savedQuestions.forEach { savedQuestion in
            if let indexInViewControllerQuestionsArray = questions.firstIndex(where: { question in
                question.questionCopy == savedQuestion.questionCopy
            }) {
                questions[indexInViewControllerQuestionsArray] = savedQuestion
            }
        }
    }

    

    override func viewDidLoad() {
        super.viewDidLoad()

//        print(UserDefaults.standard.dictionaryRepresentation())
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        guard let url = Bundle.main.url(forResource: "ch9Questions", withExtension: "json"),
            let ch9JSONData = try? Data(contentsOf: url),
            let ch9questions = try? JSONDecoder().decode(Array<Question>.self, from: ch9JSONData) else {
                print("Error loading JSON")
                fatalError()
        }

        self.questions = ch9questions
        checkForSavedSelectedQuestions()
        let questionsNib = UINib(nibName: "QuestionsTableViewCell", bundle: nil)
        tableView.register(questionsNib, forCellReuseIdentifier: "QuestionsTableViewCell")
       // tableView.estimatedRowHeight = 50
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.questions.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionsTableViewCell", for: indexPath) as! QuestionsTableViewCell
        let row = indexPath.row
        cell.configure(questionCopy: questions[row].questionCopy, isSelected: questions[row].isSelected, setDelegate: self)

        return cell
    }
}
    
    
    
    
//
//    // MARK: This question array is for the tableView data
//    var questions = [Question]()
//    // MARK: This question array is for the user selected questions
//    var selectedQuestions = [Question]()
//
//    func switchButtonTapped(WithStatus status: Bool, ForCell myCell: QuestionsTableViewCell) {
//        // using guard let syntax to unwrap the optional; if it returns nil then it exits the function and does nothing
//        guard let indexPath = self.tableView.indexPath(for: myCell) else { return }
//        print("cell at indexpath \(String(describing: indexPath)) tapped with switch status \(status)")
//        let ch9SwitchSelected = myCell.questionLabel.text!
//        print("Question added/removed was \(String(describing: ch9SwitchSelected))")
//        // MARK: - This code block adds or removes selected ingredients based on the status of the switch.
//        if status {
//            selectedQuestions.append(questions[indexPath.row])
//        } else {
//            // MARK: - This logic is here in the event that a given ingredient isn't in the selected ingredients array
//            guard let index = selectedQuestions.firstIndex(where: { $0.questionCopy == questions[indexPath.row].questionCopy }) else { return }
//            selectedQuestions.remove(at: index)
//        }
//    }
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.estimatedRowHeight = 600
//        // Uncomment the following line to preserve selection between presentations
//        // self.clearsSelectionOnViewWillAppear = false
//
//        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//        // self.navigationItem.rightBarButtonItem = self.editButtonItem
//        guard let url = Bundle.main.url(forResource: "ch9Questions", withExtension: "json"),
//            let ch9JSONData = try? Data(contentsOf: url),
//            let ch9questions = try? JSONDecoder().decode(Array<Question>.self, from: ch9JSONData) else {
//                print("Error loading JSON")
//                fatalError()
//        }
//        print(ch9questions)
//        self.questions = ch9questions
//        let questionsNib = UINib(nibName: "QuestionsTableViewCell", bundle: nil)
//        tableView.register(questionsNib, forCellReuseIdentifier: "QuestionsTableViewCell")
//        tableView.estimatedRowHeight = 50
//    }
//
//    // MARK: - Table view data source
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return self.questions.count
//    }
//
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionsTableViewCell", for: indexPath) as! QuestionsTableViewCell
//        let row = indexPath.row
//        cell.configure(questionCopy: questions[row].questionCopy, isSelected: selectedQuestions.contains {$0.questionCopy == questions[row].questionCopy}, setDelegate: self)
//
//        return cell
//}
//}
//
//
//
