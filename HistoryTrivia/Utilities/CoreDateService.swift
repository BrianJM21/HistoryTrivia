//
//  CoreDateService.swift
//  HistoryTrivia
//
//  Created by Brian Jiménez Moedano on 12/02/23.
//

import Foundation
import CoreData

struct CoreDataService {
    
    static let shared = CoreDataService()
    
    private let container: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "QuestionEntity")
        container.loadPersistentStores {
            
            _, error in
            
            if let error = error {
                
                fatalError("[CoreDataService] Error al crear contenedor persistente.")
            }
        }
        return container
    }()
    
    func load() {
        
        if let  customQuestions = try? self.container.viewContext.fetch(QuestionEntity.fetchRequest()) {
            
            for customQuestion in customQuestions {
                
                guard let question = customQuestion.question else { return }
                guard let answerOne = customQuestion.answerOne else { return }
                guard let answerTwo = customQuestion.answerTwo else { return }
                guard let answerThree = customQuestion.answerThree else { return }
                guard let answerFour = customQuestion.answerFour else { return }

                GameModel.addQuestion(question: question, answers: [answerOne, answerTwo, answerThree, answerFour], correctAnswerIndex: Int(customQuestion.correctAnswer))
            }
        }
    }
    
    func save(question: String, answers: [String], correctAnswer: Int) {
        
        let customQuestion = QuestionEntity(context: self.container.viewContext)
        
        customQuestion.question = question
        customQuestion.answerOne = answers[0]
        customQuestion.answerTwo = answers[1]
        customQuestion.answerThree = answers[2]
        customQuestion.answerFour = answers[3]
        customQuestion.correctAnswer = Int16(correctAnswer)
        
        do {
            
            try self.container.viewContext.save()
        } catch {
            
            self.container.viewContext.rollback()
        }
    }
}
