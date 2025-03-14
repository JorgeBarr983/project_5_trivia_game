//
//  CardView.swift
//  Trivia Game
//
//  Created by Jorge Barrera on 3/14/25.
//

import Foundation
import SwiftUI

struct CardView: View {
    let trivia: Trivia
    @Binding var selectedAnswers: [String: String]
    let isSubmitted: Bool

    var body: some View {
        VStack {
            Text(trivia.question)
                .font(.headline)
                .padding()

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
                                : Color.white
                        )
                        .cornerRadius(8)
                        .shadow(radius: 2)
                }
                .disabled(isSubmitted)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 4)
    }
}
