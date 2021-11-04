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
    let stackView = UIStackView()
    let chapterNumber: ChapterNumber?
    let pageContent: [PageContent]
    
    init(dataContent: [PageContent], chapterNumber: ChapterNumber? = nil) {
        self.pageContent = dataContent
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
        [scrollView, stackView].forEach { eachOne in
            eachOne.translatesAutoresizingMaskIntoConstraints = false
        }
     
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 16
        
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
        
        let displayContent = buildDisplayContent(from: pageContent)
        addContentToStackView(displayContent: displayContent)
        
        if let chapterNumber = chapterNumber {
            let button = chapterButton(for: chapterNumber)
            stackView.addArrangedSubview(button)
        }
    }
    
    // MARK: - Converting Text and Images to views for the Screen
    
    func buildDisplayContent(from pageContent: [PageContent]) -> [UIView] {
        var displayContent = [UIView]()
        
        pageContent.forEach { item in
            switch item {
            case let .text(text):
                let generatedLabel = buildLabel(text: text)
                displayContent.append(generatedLabel)
                
            case let .image(image):
                let generatedImage = buildImageView(image: image)
                displayContent.append(generatedImage)

            case let .customText(customText):
                print("Add support for building a label with custom text later on. I will convert this to normal text")
                let normalText = customText.string
                let generatedLabel = buildLabel(text: normalText)
                displayContent.append(generatedLabel)
            }
        }

        return displayContent
    }
    
    func addContentToStackView(displayContent: [UIView]) {
        displayContent.forEach { eachOne in
            stackView.addArrangedSubview(eachOne)
        }
    }
    
    private func buildLabel(text: String) -> UILabel {
        let generatedLabel = UILabel()
        generatedLabel.translatesAutoresizingMaskIntoConstraints = false
        generatedLabel.text = text
        generatedLabel.textColor = .label
        generatedLabel.font = UIFont.preferredFont(forTextStyle: .body)
        generatedLabel.numberOfLines = 0
        
        return generatedLabel
    }
    
    private func buildImageView(image: UIImage?) -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: 142).isActive = true
        
        return imageView
    }
    
    // MARK: - Chapter Button
    
    func chapterButton(for chapter: ChapterNumber) -> UIButton {
        // This action sends you to the QuestionsTableViewController
        let action = UIAction { [weak self] action in
            let questionsTVC = QuestionTableViewController(chapter: chapter)
            self?.navigationController?.pushViewController(questionsTVC, animated: true)
        }

        let button = UIButton(primaryAction: action)
        button.setTitle("Go to \(chapter.displayCh) Questions", for: .normal)
        button.layer.cornerRadius = 20
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemYellow
        return button
    }
}

