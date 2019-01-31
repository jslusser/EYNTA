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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(questionCopy: String, isSelected: Bool, setDelegate: CellProtocol) {
        questionLabel.text = questionCopy
        questionLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        delegate = setDelegate
    }
}

protocol CellProtocol: class {
    func switchButtonTapped(WithStatus status: Bool, ForCell myCell: QuestionsTableViewCell)
}
