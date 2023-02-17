//
//  QuestionViewModel.swift
//  HistoryTrivia
//
//  Created by Brian Jiménez Moedano on 07/02/23.
//

import Foundation

class GameViewModel: ObservableObject {
    
    // Publica cada vez que cambia el estado del modelo Game.
    
    @Published private var game = GameModel()
    
    // Contiene la pregunta actual, según el estado del modelo Game.
    
    var currentQuestion: QuestionModel {
        
        self.game.currentQuestion
    }
    
    // Contiene el progreso del juego en forma de una String, que también será la cabecera de la vista del juego.
    
    var questionProgressText: String {
        "\(self.game.currentQuestionIndex + 1) / \(self.game.numberOfQuestions)"
      }
    
    // Computa si ya se ha elegido una respuesta para la pregunta actual.
    
    var guessWasMade: Bool {
        
        if let _ = self.game.guesses[self.currentQuestion] {
            
            return true
        } else {
            
            return false
        }
    }
    
    // Comprueba si el juego ha terminado.
    
    var gameIsOver: Bool {
        
        self.game.isOver
    }
    
    // Despliega las respuestas correctas e incorrectas.
    
    var correctGuesses: Int {
        
        self.game.guessCount.correct
    }
    
    var incorrectGuesses: Int {
        
        self.game.guessCount.incorrect
    }
    
    // Guarda la respuesta de la pregunta actual.
    
    func makeGuess(atIndex index: Int) {
        
        self.game.makeGuessForCurrentQuestion(atIndex: index)
    }
    
    // Actualiza/Progresa el estado del juego.
    
    func displayNextQuestion() {
        
        self.game.updateGameStatus()
    }
    
}
