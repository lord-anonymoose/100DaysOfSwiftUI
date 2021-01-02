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
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    
    func calculateBedTime () {
        let model = SleepCalculator()
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        do {
            let prediction = try
                model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let bedTime = wakeUp - prediction.actualSleep
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            alertTitle = "Your ideal bedtime is..."
            alertMessage = formatter.string(from: bedTime)

        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, something went wrong!"
        }
        showingAlert = true
    }
    
    var body: some View {
        NavigationView {
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
                
                Text("Amount of coffee intake:")
                    .font(.headline)
                Stepper(value: $coffeeAmount, in: 1...20, step: 1) {
                    if (coffeeAmount == 1)  {
                        Text ("1 cup")
                    } else {
                        Text ("\(coffeeAmount) cups")
                    }
                }
            }
            .navigationBarTitle("Better Sleep")
            .navigationBarItems(trailing:
                                    Button(action: calculateBedTime) {
                                        Text("Calculate")
                                    }
            )
            .alert(isPresented: $showingAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage)
                      , dismissButton: .default(Text("OK")))
            }
            .padding(.leading, 20)
            .padding(.trailing, 20)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
