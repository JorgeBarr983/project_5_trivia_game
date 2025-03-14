//
//  QuestionView.swift
//  Trivia Game
//
//  Created by Jorge Barrera on 3/14/25.
//

import Foundation
import SwiftUI

struct QuestionView: View {
    let trivia: Trivia
    @Binding var selectedAnswers: [String: String]
    let isSubmitted: Bool

    var body: some View {
        VStack(alignment: .leading) {
            Text(trivia.question)
                .font(.headline)
                .padding(.bottom, 5)

            ForEach(trivia.shuffledAnswers, id: \.self) { answer in
                Button(action: {
                    selectedAnswers[trivia.question] = answer
                }) {
                    Text(answer)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            selectedAnswers[trivia.question] == answer
                                ? (answer == trivia.correct_answer ? Color.green : Color.red)
                                : Color.clear
                        )
                        .cornerRadius(8)
                        .foregroundColor(.white)
                }
                .disabled(isSubmitted)
            }
        }
        .padding()
    }
}
