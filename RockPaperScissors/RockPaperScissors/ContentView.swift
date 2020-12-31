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
        VStack {
            Text("🤖")
                .font(.system(size: 50))
            Text("Apps move:")
            ZStack {
                Circle()
                    .frame(width: 170, height: 170, alignment: .center)
                    .foregroundColor(.yellow)
                    .shadow(color: .black, radius: 10)
                Text(choice)
                    .font(.system(size: 70))
            }
        }
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

struct ContentView: View {
    @State private var choices = ["❓", "🪨", "📃", "✂️"]
    @State private var buttonColors = [Color.orange, Color.orange, Color.orange, Color.orange]
    @State private var playerChoice = 0
    @State private var appChoice = 0
    @State private var score = 0
    @State private var turns = 0
    
    var result: String {
        var returnValue = ""
        if (choices[playerChoice] == "🪨") && (choices[appChoice] == "✂️") {
            returnValue = "🎉 You won!"
        } else if (choices[playerChoice] == "📃") && (choices[appChoice] == "🪨") {
            returnValue = "🎉 You won!"
        } else if (choices[playerChoice] == "✂️") && (choices[appChoice] == "📃") {
            returnValue = "🎉 You won!"
        } else if (playerChoice == appChoice) && (playerChoice != 0) {
            returnValue = "🤝 It's a tie!"
        } else if (playerChoice == 0) && (appChoice == 0) {
            returnValue = "🏁 Let's start the game!"
        } else {
            returnValue = "💩 You lost!"
        }
        return returnValue
    }
    
    func buttonTapped (_ button: Int) {
        playerChoice = button
        appChoice = Int.random(in: 1...3)
        
        for i in 0...3 {
            buttonColors[i] = .orange
        }
        switch result {
        case "🎉 You won!":
            buttonColors[button] = .green
            score += 1
        case "💩 You lost!":
            buttonColors[button] = .red
        default:
            buttonColors[button] = .white
        }
        
        turns += 1
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.green, Color.yellow, Color.orange]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                Text(result)
                    .font(.largeTitle)
                Spacer()
                appMove(choice: choices[appChoice])
                Spacer()
                Text("My move:")
                HStack {
                    ForEach(1..<4) {i in
                        Button (action: {
                            buttonTapped(i)
                        }) {
                            buttonView(choice: choices[i], color: buttonColors[i])
                        }
                    }
                }
                Text ("Your won: \(score)/\(turns)")
            }
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
