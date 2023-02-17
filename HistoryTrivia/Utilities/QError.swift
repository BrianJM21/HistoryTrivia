//
//  QError.swift
//  HistoryTrivia
//
//  Created by Brian Jiménez Moedano on 09/02/23.
//

import Foundation

// Errores personalizados.

enum QError: Error {
    
    case questionTextIsEmpty
    case possibleAnswerIsEmpty
    case invalidPossibleAnswers
    case correctAnswerIndexIsEmpty
    case invalidCorrectAnswerIndex
    case questionAlredyExists
    case numberOfQuestionsIsEmpty
    case invalidNumberOfQuestions
}

// Descripción de los errores.

extension QError: LocalizedError {
    
    public var errorDescription: String? {
        
        switch self {
        
        case .questionTextIsEmpty: return NSLocalizedString("El cuerpo de la pregunta está vació.", comment: "")
            
        case .possibleAnswerIsEmpty: return NSLocalizedString("El cuerpo de alguna posible respuesta está vacío.", comment: "")
            
        case .invalidPossibleAnswers: return NSLocalizedString("El número de posibles respuestas es diferente de 4.", comment: "")
            
        case .correctAnswerIndexIsEmpty: return NSLocalizedString("El cuerpo de la respuesta correcta está vacío.", comment: "")
            
        case .invalidCorrectAnswerIndex: return NSLocalizedString("La respuesta correcta está fuera de los límites numéricos permitidos [1 - 4].", comment: "")
            
        case .questionAlredyExists: return NSLocalizedString("Esa pregunta ya existe.", comment: "")
            
        case .numberOfQuestionsIsEmpty: return NSLocalizedString("Ingrese un número de preguntas válido.", comment: "")
            
        case .invalidNumberOfQuestions: return NSLocalizedString("Ingrese un número de preguntas válido.", comment: "")
        }
    }
}
