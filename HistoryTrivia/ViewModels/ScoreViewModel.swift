//
//  ScoreViewModel.swift
//  HistoryTrivia
//
//  Created by Brian Jiménez Moedano on 10/02/23.
//

import Foundation

class ScoreViewModel {
    
    let correctGuesses: Int
    let incorrectGuesses: Int
     
    var percentage: Int {
        
        (correctGuesses * 100 / (correctGuesses + incorrectGuesses))
    }
    
    init(correctGuesses: Int, incorrectGuesses: Int) {
        self.correctGuesses = correctGuesses
        self.incorrectGuesses = incorrectGuesses
    }
}
