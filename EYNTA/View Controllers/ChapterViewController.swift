//
//  QuestionlessChapterViewController.swift
//  EYNTA
//
//  Created by James Slusser on 10/15/21.
//  Copyright © 2021 James Slusser. All rights reserved.
//

import UIKit

class ChapterViewController: UIViewController {

    let scrollView = UIScrollView()
    let textLabel = UILabel()
    let stackView = UIStackView()
    let imageView = UIImageView()
    let image: UIImage?
    let chapterNumber: ChapterNumber?
    
    init(text: String, image: UIImage? = nil, chapterNumber: ChapterNumber? = nil) {
        self.textLabel.text = text
        self.image = image
        self.chapterNumber = chapterNumber
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    func setupLayout() {
        [scrollView, stackView, textLabel].forEach { eachOne in
            eachOne.translatesAutoresizingMaskIntoConstraints = false
        }

     
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 16
        
        textLabel.textColor = .black
        textLabel.font = UIFont.preferredFont(forTextStyle: .body)
        textLabel.numberOfLines = 0
        
        let guide = view.readableContentGuide
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: guide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        if let image = image {
            setupImageView(image: image)
        }
        stackView.addArrangedSubview(textLabel)
        
        if let chapterNumber = chapterNumber {
            let button = chapterButton(for: chapterNumber)
            stackView.addArrangedSubview(button)
        }
    }
    
    func chapterButton(for chapter: ChapterNumber) -> UIButton {
        // This action sends you to the QuestionsTableViewController
        let action = UIAction { [weak self] action in
            let questionsTVC = QuestionTableViewController(chapter: chapter)
            self?.navigationController?.pushViewController(questionsTVC, animated: true)
        }

        let button = UIButton(primaryAction: action)
        button.setTitle("Go to \(chapter.rawValue.capitalized) Questions", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemYellow
        return button
    }
    
    func setupImageView(image: UIImage) {
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(imageView)
        imageView.heightAnchor.constraint(equalToConstant: 142).isActive = true
    }
}

