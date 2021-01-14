//
//  ContentView.swift
//  Edutainment
//
//  Created by Philipp on 12.01.2021.
//

import SwiftUI

struct gameData {
    var tables: Int
    var questions: Int
    
}

struct ContentView: View {
    @State private var gameStarted = false
    @State private var tables = 1
    @State private var questions = 5
    let questionOptions = ["5", "10", "20", "All"]
    
    
    var body: some View {
        NavigationView {
            VStack {
                
                Text("What tables you want to practice: ")
                    .font(.headline)
                Stepper(value: $tables, in: 1...12, step: 1) {
                    Text("Tables up to \(tables)")
                }
                .padding(.bottom, 20)
                .padding()
                
                Text("How many questions?")
                    .font(.headline)
                Picker("Questions",selection: $questions) {
                    ForEach (0..<questionOptions.count) {
                            Text("\(questionOptions[$0])")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.bottom, 20)
                .padding()
                
                Button("Start game") {
                    self.gameStarted.toggle()
                }
            }
            .sheet(isPresented: $gameStarted) {
                gameView(maxTable: tables, questions: questions)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
