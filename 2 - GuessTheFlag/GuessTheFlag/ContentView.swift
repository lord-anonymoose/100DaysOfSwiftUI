//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Philipp on 26.12.2020.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingAlert = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var currentFlag = 0
    
    @State private var animationAmount = 0.0
    @State private var opacity: Double = 1.0

    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack (spacing:30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        withAnimation {
                            self.animationAmount += 360
                            self.opacity -= 0.75
                        }
                        self.flagTapped(number)
                        
                    }
                    ) {
                        
                        flagView(image: self.countries[number])
                            .rotation3DEffect(.degrees(number == correctAnswer ? animationAmount: 0), axis: (x: 0, y: 1, z: 0))
                            .opacity(number != correctAnswer ? opacity: 1.0)
                    }
                }
                Text("Your score: \(score)")
                    .foregroundColor(.white)
            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(scoreTitle), message: Text("This is a flag of \(countries[currentFlag])"), dismissButton: .default(Text("Continue")) {
              self.askQuestion()
            }
            )
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                askQuestion()
            }
        } else {
            scoreTitle = "Wrong"
            currentFlag = number
            showingAlert = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        withAnimation {
            opacity = 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
