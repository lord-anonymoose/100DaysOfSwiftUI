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
            RoundedRectangle(cornerRadius: 25)
                .frame(width: 120, height: 120, alignment: .center)
                .foregroundColor(.yellow)
                .shadow(color: .black, radius: 5)
            Text(choice)
                .font(.system(size: 70))
        }
    }
}

struct buttonView: View {
    var choice: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .frame(width: 70, height: 70, alignment: .center)
                .foregroundColor(.orange)
                .shadow(color:.black, radius: 3)
            Text(choice)
                .font(.system(size: 35))
        }
    }
}

func didWin (playerChoice: String, appChoice: String) -> Bool {
    var returnValue = false
    if (playerChoice == "🪨") && (appChoice == "✂️") {
        returnValue = true
    } else if (playerChoice == "📃") && (appChoice == "🪨") {
        returnValue = true
    } else if (playerChoice == "✂️") && (appChoice == "📃") {
        returnValue = true
    }
    return returnValue
}

struct ContentView: View {
    @State private var choices = ["❓", "🪨", "📃", "✂️"]
    @State private var playerChoice = 0
    @State private var computerChoice = 0
    @State private var score = 0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.green, Color.yellow, Color.orange]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Apps move:")
                    .foregroundColor(.white)
                appMove(choice: "📱")
                Text("My move:")
                HStack {
                    buttonView(choice: "🪨")
                    buttonView(choice: "📃")
                    buttonView(choice: "✂️")
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
