//
//  settingsView.swift
//  Edutainment
//
//  Created by Philipp on 12.01.2021.
//

import SwiftUI

struct settingsView: View {
    
    @ObservedObject var data = gameData()
    
    var body: some View {
        VStack {
            
            VStack {
                Text("What tables to practise?")
                    .font(.headline)
                Stepper(value: $data.practicedTable, in: 1...12, step: 1) {
                    Text("Up to \(data.practicedTable)")
                }
                .padding(.trailing, 60)
                .padding(.leading, 60)
            }
            .padding(.bottom, 50)
            
            VStack {
                Text("How many questions?")
                    .font(.headline)
                
                Picker("Questions: ", selection: $data.questions) {
                    ForEach (0..<data.questionOptions.count) {
                        if data.questionOptions[$0] == 0 {
                            Text("All")
                        } else {
                            Text("\(data.questionOptions[$0])")
                        }
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.leading, 20)
                .padding(.trailing, 20)
            }
            .padding(.bottom, 50)
            
            Button("Start") {
                data.gameStarted.toggle()
                print(data.gameStarted)
            }
        }
    }
}
struct settingsView_Previews: PreviewProvider {
    static var previews: some View {
        settingsView()
    }
}
