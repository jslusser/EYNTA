//
//  QuestionStorage.swift
//  EYNTA
//
//  Created by James Slusser on 2/18/21.
//  Copyright © 2021 James Slusser. All rights reserved.
//

import Foundation

class QuestionStorage {
    static let shared = QuestionStorage()
    private let userDefaults = UserDefaults.standard
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    
    func getSelectedQuestions(by chapter: ChapterNumber) -> [Question] {
        guard let dataArray = userDefaults.value(forKey: chapter.rawValue) as? [Data] else { return [Question]() }
        
        let questionsArray = dataArray.compactMap { try? decoder.decode(Question.self, from: $0) }
        print("I Found the questions \(questionsArray)")
        
        return questionsArray
    }
    
    func saveAllSelectedQuestions(chapter: ChapterNumber, questions: [Question]) {
        print("I will now save all these questions for \(chapter.rawValue): \(questions)")
        
        let dataArray = questions.compactMap{ try? encoder.encode($0) }
            
        userDefaults.set(dataArray, forKey: chapter.rawValue)
    }
    
    func saveSelectedQuestion(question: Question) {
        var questionsToUpdate = getSelectedQuestions(by: question.chapter)
 
        if questionsToUpdate.contains(where: { $0.questionNumber == question.questionNumber }) == false {
            //TO DO: Once order property set, change this to maintain order.
            questionsToUpdate.append(question)
        } else if let existingQuestionIndex = questionsToUpdate
            .firstIndex(where: { $0.questionNumber == question.questionNumber }) {
                questionsToUpdate[existingQuestionIndex] = question
            }

        saveAllSelectedQuestions(chapter: question.chapter, questions: questionsToUpdate)
    }

    
    func removeSelectedQuestion(question: Question) {
        var questionsToUpdate = getSelectedQuestions(by: question.chapter)
        
        if let index = questionsToUpdate.firstIndex(where: { $0.questionNumber == question.questionNumber }) {
            questionsToUpdate.remove(at: index)
        }
        
        saveAllSelectedQuestions(chapter: question.chapter, questions: questionsToUpdate)
    }
}
