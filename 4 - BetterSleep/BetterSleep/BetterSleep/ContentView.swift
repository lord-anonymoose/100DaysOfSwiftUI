//
//  ContentView.swift
//  BetterSleep
//
//  Created by Philipp on 01.01.2021.
//

import SwiftUI

let backroundGradient = Gradient(colors: [Color.blue, Color.purple, Color.black])


struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State var wakeUp = defaultWakeTime
    @State private var coffeeAmount = 1
    

    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    //@State private var showingAlert = false
    
    /*
    func calculateBedTime (when wake: Date) -> String {
        var wake: Date
        let model = SleepCalculator()
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        do {
            let prediction = try
                model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount) ?? 0)
            let bedTime = wakeUp - prediction.actualSleep
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            alertTitle = "Your ideal bedtime is..."
            alertMessage = formatter.string(from: bedTime)
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, something went wrong!"
        }
        
        //showingAlert = true
        return alertMessage
    }
     */
    
    var idealBedTime: String {
        var result = ""
        let model = SleepCalculator()
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        do {
            let prediction = try
                model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount) ?? 0)
            let bedTime = wakeUp - prediction.actualSleep
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            result = formatter.string(from: bedTime)
        } catch {
            result = "Error! Sorry, something went wrong!"
        }
        return (result)
    }
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text("When do you want to wake up?")
                        .font(.headline)
                    DatePicker("Select time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                        .frame(height: 60)
                }
                Section {
                    Text("Desired amount of sleep:")
                        .font(.headline)
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                        Text("\(sleepAmount, specifier: "%g") hours")
                    }
                }
                Section {
                    Text("Amount of coffee intake:")
                        .font(.headline)
                    /*
                    Stepper(value: $coffeeAmount, in: 1...20, step: 1) {
                        if (coffeeAmount == 1)  {1
                            Text ("1 cup")
                        } else {
                            Text ("\(coffeeAmount) cups")
                        }
                    }*/
                    
                    Picker(selection: $coffeeAmount, label: Text("Please choose amount of coffee")) {
                       ForEach(0 ..< 21) {
                        if ($0 == 1) {
                            Text("\($0) cup")
                        } else {
                            Text("\($0) cups")
                        }
                       }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(height: 60)
                }
                Section {
                    Text("Ideal bedtime is: \(idealBedTime)")
                        .font(.headline)
                }
           }
            .background(
                LinearGradient(gradient: backroundGradient, startPoint: .topLeading, endPoint: .bottomTrailing)
            )
            .navigationBarTitle("Better Sleep")
            /*
            .navigationBarItems(trailing:
                                    Button(action: calculateBedTime) {
                                        Text("Calculate")
                                    }
            )
            
                .alert(isPresented: $showingAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage)
                      , dismissButton: .default(Text("OK")))
                }
            */
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
