//
//  OptionsView.swift
//  Trivia Game
//
//  Created by Jorge Barrera on 3/14/25.
//

import SwiftUI

struct OptionsView: View {
    @State private var numberOfQuestions: Int = 10
    @State private var selectedCategory: Int = 9  // Default: General Knowledge
    @State private var selectedDifficulty: String = "easy"
    @State private var selectedType: String = "multiple"
    @State private var useCardView: Bool = false  // Toggle between List and Card view

    let categories = [
        (id: 9, name: "General Knowledge"),
        (id: 18, name: "Science: Computers"),
        (id: 23, name: "History"),
        (id: 21, name: "Sports"),
        (id: 27, name: "Animals")
    ]
    
    let difficulties = ["easy", "medium", "hard"]
    let types = ["multiple", "boolean"]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Number of Questions")) {
                    Stepper(value: $numberOfQuestions, in: 5...50, step: 5) {
                        Text("\(numberOfQuestions) Questions")
                    }
                }

                Section(header: Text("Category")) {
                    Picker("Select Category", selection: $selectedCategory) {
                        ForEach(categories, id: \.id) { category in
                            Text(category.name).tag(category.id)
                        }
                    }
                }

                Section(header: Text("Difficulty")) {
                    Picker("Select Difficulty", selection: $selectedDifficulty) {
                        ForEach(difficulties, id: \.self) { difficulty in
                            Text(difficulty.capitalized).tag(difficulty)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("Question Type")) {
                    Picker("Select Type", selection: $selectedType) {
                        ForEach(types, id: \.self) { type in
                            Text(type == "multiple" ? "Multiple Choice" : "True/False").tag(type)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("View Type")) {
                    Toggle("Use Card View", isOn: $useCardView)
                }

                Section {
                    NavigationLink(destination: ContentView(
                        numberOfQuestions: numberOfQuestions,
                        category: selectedCategory,
                        difficulty: selectedDifficulty,
                        type: selectedType,
                        useCardView: useCardView
                    )) {
                        Text("Start Game")
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                }
            }
            .navigationTitle("Trivia Options")
        }
    }
}

#Preview {
    OptionsView()
}

