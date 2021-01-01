//
//  ContentView.swift
//  BetterSleep
//
//  Created by Philipp on 01.01.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = Date()
    @State private var coffeAmount = 1
    
    var body: some View {
        NavigationView {
            //Form {
            VStack(alignment: .leading) {
                Text("When do you want to wake up?")
                    .font(.headline)
                DatePicker("Select time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                    .labelsHidden()
                    .padding(.bottom, 20)
                Text("Desired amount of sleep:")
                    .font(.headline)
                Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                    Text("\(sleepAmount, specifier: "%g") hours")
                    
                }
                .padding(.bottom, 20)
            }
            .padding(.leading, 10)
            .padding(.trailing, 10)
            //}
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
