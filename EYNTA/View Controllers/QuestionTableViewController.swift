//
//  QuestionTableViewController.swift
//  EYNTA
//
//  Created by James Slusser on 10/15/21.
//  Copyright © 2021 James Slusser. All rights reserved.
//

import UIKit

class QuestionTableViewController: UITableViewController {
    // MARK: This question array is for the tableView data
    
    var questions = [Question]()
    let chapter: ChapterNumber
    
    init(chapter: ChapterNumber) {
        self.chapter = chapter
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        print(UserDefaults.standard.dictionaryRepresentation())
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        tableView.keyboardDismissMode = .interactive

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

        self.questions = QuestionStorage.shared.getJSONQuestions(for: chapter)
        checkForSavedSelectedQuestions()
        let questionsNib = UINib(nibName: "QuestionsTableViewCell", bundle: nil)
        tableView.register(questionsNib, forCellReuseIdentifier: "QuestionsTableViewCell")
       // tableView.estimatedRowHeight = 50
    }
    
    // MARK: - Handling Changes
    func checkForSavedSelectedQuestions() {
        let savedQuestions = QuestionStorage.shared.getSelectedQuestions(by: chapter)
        
        savedQuestions.forEach { savedQuestion in
            if let indexInViewControllerQuestionsArray = questions.firstIndex(where: { question in
                question.questionCopy == savedQuestion.questionCopy
            }) {
                questions[indexInViewControllerQuestionsArray] = savedQuestion
            }
        }
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
        let question = questions[row]
        cell.configure(question: question, setDelegate: self)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("A cell was selected. Time to stop editing textviews")
        tableView.endEditing(true)
    }
}

extension QuestionTableViewController: CellProtocol {
    func switchButtonTapped(WithStatus status: Bool, ForCell myCell: QuestionsTableViewCell) {
        // using guard let syntax to unwrap the optional; if it returns nil then it exits the function and does nothing
        guard let indexPath = self.tableView.indexPath(for: myCell) else { return }
        print("cell at indexpath \(String(describing: indexPath)) tapped with switch status \(status)")
        let ch4SwitchSelected = myCell.questionLabel.text!
        print("Question added/removed was \(String(describing: ch4SwitchSelected))")
        // MARK: - This code block adds or removes selected ingredients based on the status of the switch.
        
        questions[indexPath.row].isSelected = status
        if status {
            QuestionStorage.shared.saveSelectedQuestion(question: questions[indexPath.row])
        } else {
            // MARK: - This logic is here in the event that a given ingredient isn't in the selected ingredients array
            QuestionStorage.shared.removeSelectedQuestion(question: questions[indexPath.row])
        }
        updateUI(indexPath: indexPath)
    }
    
    func answerWasUpdated(newAnswer: String, for myCell: QuestionsTableViewCell) {
        // using guard let syntax to unwrap the optional; if it returns nil then it exits the function and does nothing
        guard let indexPath = self.tableView.indexPath(for: myCell) else { return }
        print("cell at indexpath \(String(describing: indexPath)) answer was changed to\(newAnswer)")
      
        questions[indexPath.row].userAnswer = newAnswer
        
        QuestionStorage.shared.saveSelectedQuestion(question: questions[indexPath.row])
        
        updateUI(indexPath: indexPath)
    }
    
    func updateUI(indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .fade)
        
    }
}
