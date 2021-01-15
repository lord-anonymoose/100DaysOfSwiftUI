//
//  gameView.swift
//  Edutainment
//
//  Created by Philipp on 13.01.2021.
//

import SwiftUI

struct gameView: View {
    @State var maxTable: Int
    @State var questions: Int
    
    @State private var firstNumber = 0
    @State private var secondNumber = 0
    @State private var answer =  0
    @State private var userAnswer = ""
    
    @State private var resultText = ""
    
    @State var score = 0
    
    func setupQuestions() {
        switch questions {
        case 0:
            questions = 5
        case 1:
            questions = 10
        case 2:
            questions = 20
        default:
            -1
        }
    }
    
    func generateProblem() {
        self.firstNumber = Int.random(in: 1..<maxTable+1)
        self.secondNumber = Int.random(in: 1..<13)
        self.answer = firstNumber * secondNumber
    }
    
    func startGame() {
        setupQuestions()
        generateProblem()
    }
    
    var body: some View {
        VStack {
            Text("\(firstNumber) x \(secondNumber)")
                .font(.headline)
            Text("=")
                .font(.headline)
            TextField("answer", text: $userAnswer)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 70, alignment: .center)
            Button ("Check") {
                let checker = Int(userAnswer) ?? 0
                if checker == answer {
                    questions -= 1
                    generateProblem()
                }
                if questions == 0 {
                    resultText = "Game ended"
                }
            }
            Text("\(questions)")
        }
        .onAppear(perform: startGame)
    }
}

struct gameView_Previews: PreviewProvider {
    static var previews: some View {
        gameView(maxTable: Int(), questions: Int())
    }
}
