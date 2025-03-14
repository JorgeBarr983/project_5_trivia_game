//
//  TriviaResponse.swift
//  Trivia Game
//
//  Created by Jorge Barrera on 3/14/25.
//

import Foundation

struct TriviaResponse: Codable {
    let results: [Trivia]
}

struct Trivia: Codable, Identifiable {
    let id = UUID()
    let question: String
    let incorrect_answers: [String]
    let correct_answer: String
    
    var shuffledAnswers: [String] {
        (incorrect_answers + [correct_answer]).shuffled()
    }
}

