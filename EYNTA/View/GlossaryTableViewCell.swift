//
//  GlossaryTableViewCell.swift
//  EYNTA
//
//  Created by James Slusser on 10/20/21.
//  Copyright © 2021 James Slusser. All rights reserved.
//

import UIKit

class GlossaryTableViewCell: UITableViewCell {
    static let reuseId = "GlossaryTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        textLabel?.text = nil
        detailTextLabel?.text = nil
    }
    
    func configure(term: Vocabulary) {
        textLabel?.text = term.term
        detailTextLabel?.text = term.definition
        
        textLabel?.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        detailTextLabel?.numberOfLines = 0
        detailTextLabel?.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
    }
}

