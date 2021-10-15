//
//  Q5TableViewController.swift
//  EYNTA
//
//  Created by James Slusser on 1/31/19.
//  Copyright © 2019 James Slusser. All rights reserved.
//

import UIKit

class Q5TableViewController: QuestionTableViewController, CellProtocol {

    // MARK: This question array is for the tableView data
    var questions = [Question]()
//    // MARK: This question array is for the user selected questions
//    var selectedQuestions = [Question]()
    
//    func switchButtonTapped(WithStatus status: Bool, ForCell myCell: QuestionsTableViewCell) {
//        // using guard let syntax to unwrap the optional; if it returns nil then it exits the function and does nothing
//        guard let indexPath = self.tableView.indexPath(for: myCell) else { return }
//        print("cell at indexpath \(String(describing: indexPath)) tapped with switch status \(status)")
//        let ch5SwitchSelected = myCell.questionLabel.text!
//        print("Question added/removed was \(String(describing: ch5SwitchSelected))")
//        // MARK: - This code block adds or removes selected ingredients based on the status of the switch.
//
//        questions[indexPath.row].isSelected = status
//        if status {
//            QuestionStorage.shared.saveSelectedQuestion(question: questions[indexPath.row])
//        } else {
//            // MARK: - This logic is here in the event that a given ingredient isn't in the selected ingredients array
//            QuestionStorage.shared.removeSelectedQuestion(question: questions[indexPath.row])
//        }
//    }
    
    func switchButtonTapped(WithStatus status: Bool, ForCell myCell: QuestionsTableViewCell) {
        // using guard let syntax to unwrap the optional; if it returns nil then it exits the function and does nothing
        guard let indexPath = self.tableView.indexPath(for: myCell) else { return }
        print("cell at indexpath \(String(describing: indexPath)) tapped with switch status \(status)")
        let ch5SwitchSelected = myCell.questionLabel.text!
        print("Question added/removed was \(String(describing: ch5SwitchSelected))")
        // MARK: - This code block adds or removes selected ingredients based on the status of the switch.
        
        questions[indexPath.row].isSelected = status
        if status {
            QuestionStorage.shared.saveSelectedQuestion(question: questions[indexPath.row])
        } else {
            // MARK: - This logic is here in the event that a given ingredient isn't in the selected ingredients array
            QuestionStorage.shared.removeSelectedQuestion(question: questions[indexPath.row])
        }
    }
    
//    func switchButtonTapped(WithStatus status: Bool, ForCell myCell: QuestionsTableViewCell) {
//        // using guard let syntax to unwrap the optional; if it returns nil then it exits the function and does nothing
//        guard let indexPath = self.tableView.indexPath(for: myCell) else { return }
//        print("cell at indexpath \(String(describing: indexPath)) tapped with switch status \(status)")
//        let ch5SwitchSelected = myCell.questionLabel.text!
//        print("Question added/removed was \(String(describing: ch5SwitchSelected))")
//        // MARK: - This code block adds or removes selected ingredients based on the status of the switch.
//        if status {
//            selectedQuestions.append(questions[indexPath.row])
//        } else {
//            // MARK: - This logic is here in the event that a given ingredient isn't in the selected ingredients array
//            guard let index = selectedQuestions.firstIndex(where: { $0.questionCopy == questions[indexPath.row].questionCopy }) else { return }
//            selectedQuestions.remove(at: index)
//        }
//    }

    func checkForSavedSelectedQuestions() {
        let savedQuestions = QuestionStorage.shared.getSelectedQuestions(by: .ch5)
        
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
        tableView.keyboardDismissMode = .interactive
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        guard let url = Bundle.main.url(forResource: "ch5Questions", withExtension: "json"),
            let ch5JSONData = try? Data(contentsOf: url),
            let ch5questions = try? JSONDecoder().decode(Array<Question>.self, from: ch5JSONData) else {
                print("Error loading JSON")
                fatalError()
        }

        self.questions = ch5questions
        checkForSavedSelectedQuestions()
        let questionsNib = UINib(nibName: "QuestionsTableViewCell", bundle: nil)
        tableView.register(questionsNib, forCellReuseIdentifier: "QuestionsTableViewCell")
       // tableView.estimatedRowHeight = 50
    }
    
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.estimatedRowHeight = 600
//        // Uncomment the following line to preserve selection between presentations
//        // self.clearsSelectionOnViewWillAppear = false
//
//        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//        // self.navigationItem.rightBarButtonItem = self.editButtonItem
//        guard let url = Bundle.main.url(forResource: "ch5Questions", withExtension: "json"),
//            let ch5JSONData = try? Data(contentsOf: url),
//            let ch5questions = try? JSONDecoder().decode(Array<Question>.self, from: ch5JSONData) else {
//                print("Error loading JSON")
//                fatalError()
//        }
//        print(ch5questions)
//        self.questions = ch5questions
//        checkForSavedSelectedQuestions()
//        let questionsNib = UINib(nibName: "QuestionsTableViewCell", bundle: nil)
//        tableView.register(questionsNib, forCellReuseIdentifier: "QuestionsTableViewCell")
//        tableView.estimatedRowHeight = 50
//    }
    
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
  
    func answerWasUpdated(newAnswer: String, for myCell: QuestionsTableViewCell) {
        // using guard let syntax to unwrap the optional; if it returns nil then it exits the function and does nothing
        guard let indexPath = self.tableView.indexPath(for: myCell) else { return }
        print("cell at indexpath \(String(describing: indexPath)) answer was changed to\(newAnswer)")
      
        questions[indexPath.row].userAnswer = newAnswer
        
        QuestionStorage.shared.saveSelectedQuestion(question: questions[indexPath.row])
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionsTableViewCell", for: indexPath) as! QuestionsTableViewCell
//        let row = indexPath.row
//        cell.configure(questionCopy: questions[row].questionCopy, isSelected: selectedQuestions.contains {$0.questionCopy == questions[row].questionCopy}, setDelegate: self)
//        
//        return cell
//    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

