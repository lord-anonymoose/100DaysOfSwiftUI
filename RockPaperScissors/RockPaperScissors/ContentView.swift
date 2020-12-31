//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Philipp on 31.12.2020.
//

import SwiftUI

struct appMove: View {
    var choice: String
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 170, height: 170, alignment: .center)
                .foregroundColor(.yellow)
                .shadow(color: .black, radius: 10)
            Text(choice)
                .font(.system(size: 70))
        }
        .padding(.bottom, 60)
    }
}

struct buttonView: View {
    var choice: String
    var color: Color
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .frame(width: 70, height: 70, alignment: .center)
                .foregroundColor(color)
                .shadow(color:.black, radius: 3)
            Text(choice)
                .font(.system(size: 35))
        }
    }
}

func findResult (playerChoice: String, appChoice: String) -> String {
    var returnValue = ""
    if (playerChoice == "🪨") && (appChoice == "✂️") {
        returnValue = "You won!"
    } else if (playerChoice == "📃") && (appChoice == "🪨") {
        returnValue = "You won!"
    } else if (playerChoice == "✂️") && (appChoice == "📃") {
        returnValue = "You won!"
    } else if (playerChoice == appChoice) {
        returnValue = "It's a tie!"
    } else {
        returnValue = "You lost!"
    }
    return returnValue
}

struct ContentView: View {
    @State private var choices = ["❓", "🪨", "📃", "✂️"]
    @State private var buttonColors = [Color.orange, Color.orange, Color.orange]
    @State private var playerChoice = 0
    @State private var computerChoice = 0
    @State private var score = 0
    @State private var result = "Let's start the game!"
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.green, Color.yellow, Color.orange]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text(result)
                    //.rotation3DEffect(.degrees(60), axis: (x: 1, y: 0, z: 0))
                    .font(.largeTitle)
                    .padding(.bottom, 50)
                Text("Apps move:")
                    .foregroundColor(.white)
                appMove(choice: choices[computerChoice])
                Text("My move:")
                HStack {
                    ForEach(1..<4) {i in
                        Button (action: {
                            playerChoice = i
                            computerChoice = Int.random(in: 1...3)
                            for i in 0...2 {
                                buttonColors[i] = .orange
                            }
                            result = findResult(playerChoice: choices[playerChoice], appChoice: choices[computerChoice])
                            if result == "You lost!" {
                                buttonColors[i-1] = .red
                            } else if result == "You won!" {
                                buttonColors[i-1] = .green
                            } else {
                                buttonColors[i-1] = .white
                            }
                        }) {
                            buttonView(choice: choices[i], color: buttonColors[i-1])
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
