//
//  VocabularyTableViewCell.swift
//  EYNTA
//
//  Created by James Slusser on 2/3/19.
//  Copyright © 2019 James Slusser. All rights reserved.
//

import UIKit

class VocabularyTableViewCell: UITableViewCell {

    weak var delegate: CellProtocol?
    
    @IBOutlet weak var vocabularyLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(term: String) {
        vocabularyLabel.text = term
        vocabularyLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
    }    
}


