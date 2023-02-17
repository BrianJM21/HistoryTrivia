//
//  GameModel.swift
//  HistoryTrivia
//
//  Created by Brian Jiménez Moedano on 08/02/23.
//

import Foundation

struct GameModel {
    
    private(set) var currentQuestionIndex = 0
    private(set) var guesses = [QuestionModel: Int]()
    private(set) var isOver = false
    static var gameQuestions: Int = 0
    private let questions: [QuestionModel] = {
        
        let sliceQuestions = QuestionModel.allQuestions.shuffled()[0...gameQuestions - 1]
        let questions: [QuestionModel] = []
        
        return questions + sliceQuestions
    }()
    
    // Regresa el número de aciertos y errores que ha tenido el jugador por cada pregunta respondida hasta el momento.
    
    var guessCount: (correct: Int, incorrect: Int) {
        
        var count: (correct: Int, incorrect: Int) = (0, 0)
        for (question, guessedIndex) in self.guesses {
            
            if question.correctAnswerIndex == guessedIndex {
                
                count.correct += 1
            } else {
                
                count.incorrect += 1
            }
        }
        return count
    }
    
    // Regresa el número de preguntas totales.
    
    var numberOfQuestions: Int {
        
        self.questions.count
    }
     
    // Almacena la pregunta actual.
    
    var currentQuestion: QuestionModel {
        
        self.questions[self.currentQuestionIndex]
    }
    
    // Almacena la respuesta dada por el jugador (en forma de índice) de la pregunta actual.
    
    mutating func makeGuessForCurrentQuestion(atIndex index: Int) {
        
        self.guesses[self.currentQuestion] = index
    }
    
    // Actualiza el índice de la pregunta actual, si éste es igual o mayor al total de preguntas, finaliza el juego.
    
    mutating func updateGameStatus() {
        
        if self.currentQuestionIndex < self.numberOfQuestions - 1 {
            
            self.currentQuestionIndex += 1
        } else {
            
            self.isOver = true
        }
    }
    
    // Agrega preguntas personalizadas.
    
    static func addQuestion (question questionText: String, answers possibleAnswers: [String], correctAnswerIndex: Int, completion: @escaping (Result<QuestionModel, Error>) -> Void = { _ in } ) -> Void {
        
        guard !questionText.isEmpty else { completion(.failure(QError.questionTextIsEmpty)); return }
        
        for question in QuestionModel.allQuestions {
            
            guard questionText != question.questionText else { completion(.failure(QError.questionAlredyExists)); return}
        }
        
        guard possibleAnswers.count == 4 else { completion(.failure(QError.invalidPossibleAnswers)); return }
        
        guard correctAnswerIndex >= 0 && correctAnswerIndex <= 3 else { completion(.failure(QError.invalidCorrectAnswerIndex)); return }
        
        QuestionModel.allQuestions.append(QuestionModel(questionText: questionText, possibleAnswers: possibleAnswers, correctAnswerIndex: correctAnswerIndex))
        completion(.success(QuestionModel.allQuestions.last!))
    }
    
}
