//
//  QuestionModel.swift
//  HistoryTrivia
//
//  Created by Brian Jiménez Moedano on 07/02/23.
//

import Foundation

struct QuestionModel: Hashable {
    
    let questionText: String
    let possibleAnswers: [String]
    let correctAnswerIndex: Int
    
    // Variable global con todas las preguntas disponibles por default.
    
    static var allQuestions = [
        QuestionModel(questionText: "¿Quién descubrió América?",
                      possibleAnswers: [
                        "Mahatma Gandhi",
                        "Cristobal Colón",
                        "Leonardo da Vinci",
                        "Julio César"],
                      correctAnswerIndex: 1),
        QuestionModel(questionText: "¿Quién fue la primera persona en ir a la Luna?",
                      possibleAnswers: [
                        "Yuri Gagarin",
                        "Rodolfo Neri Vela",
                        "Buzz Aldrin",
                        "Neil Armstrong"],
                      correctAnswerIndex: 3),
        QuestionModel(questionText: "¿Cuál era la capital del Imperio Inca",
                      possibleAnswers: [
                        "Tenochtitlán",
                        "Santiago",
                        "Cusco",
                        "Yucatán"],
                      correctAnswerIndex: 2),
        QuestionModel(questionText: "¿En qué año estalló la Revolución Francesa?",
                      possibleAnswers: [
                        "1789",
                        "1780",
                        "1785",
                        "1783"],
                      correctAnswerIndex: 0),
        QuestionModel(questionText: "¿Quién fue el primer emperador de Roma?",
                      possibleAnswers: [
                        "Augusto",
                        "Julio",
                        "Calígula",
                        "Nerón"],
                      correctAnswerIndex: 0),
        QuestionModel(questionText: "¿Qué tela muy preciada fue inventada en la antigüa China?",
                      possibleAnswers: [
                        "Mezclilla",
                        "Lino",
                        "Seda",
                        "Popelina"],
                      correctAnswerIndex: 2),
        QuestionModel(questionText: "¿En que año salió el primer iPhone?",
                      possibleAnswers: [
                        "2005",
                        "2007",
                        "2000",
                        "2010"],
                      correctAnswerIndex: 1),
        QuestionModel(questionText: "¿En qué año cayó el Muro de Berlín?",
                      possibleAnswers: [
                        "1990",
                        "1985",
                        "1991",
                        "1989"],
                      correctAnswerIndex: 3),
        QuestionModel(questionText: "¿Cuál es el nombre de la primera oveja clonada en un laboratorio?",
                      possibleAnswers: [
                        "Dolly",
                        "Clara",
                        "Mummy",
                        "Clony"],
                      correctAnswerIndex: 0),
        QuestionModel(questionText: "¿La compra de Alaska se dio entre que paises?",
                      possibleAnswers: [
                        "EEUU y Rusia",
                        "EEUU y China",
                        "México y EEUU",
                        "Inglaterra y EEUU"],
                      correctAnswerIndex: 0)]
    
}
