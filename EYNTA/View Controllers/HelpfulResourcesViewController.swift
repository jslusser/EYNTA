//
//  HelpfulResourcesViewController.swift
//  EYNTA
//
//  Created by James Slusser on 10/20/21.
//  Copyright © 2021 James Slusser. All rights reserved.
//

import UIKit

class HelpfulResourcesViewController: UIViewController {
    
    var textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.dataDetectorTypes = [.link]
        textView.isEditable = false
        textView.isSelectable = true
        textView.font = UIFont.preferredFont(forTextStyle: .headline)
        return textView
    }()
    
    init(text: String) {
        super.init(nibName: nil, bundle: nil)
        textView.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        setupConstraints()
    }
    
    func setupConstraints() {
        view.addSubview(textView)
        let guide = view.readableContentGuide
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: guide.topAnchor),
            textView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        ])
    }
}
