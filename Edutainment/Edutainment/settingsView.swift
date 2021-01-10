//
//  settingsView.swift
//  Edutainment
//
//  Created by Philipp on 10.01.2021.
//

/*
import SwiftUI

struct settingsView: View {
    @State var practicedTable: Int
    let questionOptions: [Int]
    @State var questions: Int
    @State var gameStarted: Bool
    
    var body: some View {
        VStack {
            
            VStack {
                Text("What tables to practise?")
                    .font(.headline)
                Stepper(value: $practicedTable, in: 1...12, step: 1) {
                    Text("Up to \(practicedTable)")
                }
                .padding(.trailing, 60)
                .padding(.leading, 60)
            }
            .padding(.bottom, 50)
            
            VStack {
                Text("How many questions?")
                    .font(.headline)
                
                Picker("Questions: ", selection: $questions) {
                    ForEach (0..<questionOptions.count) {
                        if self.questionOptions[$0] == 0 {
                            Text("All")
                        } else {
                            Text("\(self.questionOptions[$0])")
                        }
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.leading, 20)
                .padding(.trailing, 20)
            }
            .padding(.bottom, 50)
            
            Button("Start") {
                self.gameStarted.toggle()
            }
        }
    }
}
*/
