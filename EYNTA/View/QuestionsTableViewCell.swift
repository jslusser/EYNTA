//
//  QuestionsTableViewCell.swift
//  EYNTA
//
//  Created by James Slusser on 1/31/19.
//  Copyright © 2019 James Slusser. All rights reserved.
//

import UIKit

class QuestionsTableViewCell: UITableViewCell {
    
    weak var delegate: CellProtocol?
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionSwitch: UISwitch!
    @IBAction func switchTapped(_ sender: UISwitch) {
        self.delegate?.switchButtonTapped(WithStatus: sender.isOn, ForCell: self)
    }

    @IBOutlet weak var answerTextView: UITextView!
    
    var question: Question?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        answerTextView.delegate = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(question: Question, setDelegate: CellProtocol) {
        questionLabel.text = question.questionCopy
        questionLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        questionSwitch.isOn = question.isSelected
        answerTextView.text = question.userAnswer
        answerTextView.isEditable = question.isSelected
        delegate = setDelegate
    }
}

extension QuestionsTableViewCell: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        let newAnswer = textView.text ?? ""
        delegate?.answerWasUpdated(newAnswer: newAnswer, for: self)
    }
}

protocol CellProtocol: AnyObject {
    func switchButtonTapped(WithStatus status: Bool, ForCell myCell: QuestionsTableViewCell)
    func answerWasUpdated(newAnswer: String, for myCell: QuestionsTableViewCell)
}

class QuestionTableViewController: UITableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("A cell was selected. Time to stop editing textviews")
        tableView.endEditing(true)
    }
}
