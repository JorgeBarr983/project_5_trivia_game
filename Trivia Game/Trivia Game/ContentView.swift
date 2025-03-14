//
//  ContentView.swift
//  Trivia Game
//
//  Created by Jorge Barrera on 3/14/25.
//

import SwiftUI

struct ContentView: View {
    let numberOfQuestions: Int
    let category: Int
    let difficulty: String
    let type: String
    let useCardView: Bool

    @State private var triviaQuestions: [Trivia] = []
    @State private var selectedAnswers: [String: String] = [:]
    @State private var isSubmitted = false
    @State private var score = 0
    @State private var timerValue = 30  // Timer starting value (30 seconds)
    @State private var timerIsRunning = true

    // This function will start the timer for the current question
    var timer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timerValue > 0 && timerIsRunning {
                timerValue -= 1
            } else {
                submitAnswers()
            }
        }
    }

    var body: some View {
        VStack {
            if triviaQuestions.isEmpty {
                ProgressView("Loading Questions...")
                    .onAppear {
                        fetchTrivia()
                    }
            } else {
                Text("Time remaining: \(timerValue) seconds")
                    .font(.title)
                    .foregroundColor(timerValue <= 5 ? .red : .green)
                    .padding()

                if useCardView {
                    ScrollView {
                        VStack {
                            ForEach(triviaQuestions, id: \.question) { trivia in
                                CardView(trivia: trivia, selectedAnswers: $selectedAnswers, isSubmitted: isSubmitted)
                                    .padding(.horizontal)
                            }
                        }
                    }
                } else {
                    List {
                        ForEach(triviaQuestions, id: \.question) { trivia in
                            QuestionView(trivia: trivia, selectedAnswers: $selectedAnswers, isSubmitted: isSubmitted)
                        }
                    }
                }

                Button(action: submitAnswers) {
                    Text("Submit Answers")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding()
                }
                .disabled(isSubmitted || selectedAnswers.count < triviaQuestions.count)

                if isSubmitted {
                    Text("Your Score: \(score) / \(triviaQuestions.count)")
                        .font(.title)
                        .padding()
                        .foregroundColor(.red)
                }
            }
        }
        .onAppear {
            timer // Start the timer as soon as the view appears
        }
    }

    func fetchTrivia() {
        Task {
            let urlString = "https://opentdb.com/api.php?amount=\(numberOfQuestions)&category=\(category)&difficulty=\(difficulty)&type=\(type)"
            guard let url = URL(string: urlString) else { return }

            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let decodedResponse = try JSONDecoder().decode(TriviaResponse.self, from: data)

                DispatchQueue.main.async {
                    triviaQuestions = decodedResponse.results
                    timerValue = 30  // Reset timer to 30 seconds for the first question
                }
            } catch {
                print("Error fetching trivia: \(error.localizedDescription)")
            }
        }
    }

    func submitAnswers() {
        isSubmitted = true
        timerIsRunning = false  // Stop the timer when the answers are submitted
        score = triviaQuestions.reduce(0) { total, trivia in
            return total + (selectedAnswers[trivia.question] == trivia.correct_answer ? 1 : 0)
        }
    }
}
