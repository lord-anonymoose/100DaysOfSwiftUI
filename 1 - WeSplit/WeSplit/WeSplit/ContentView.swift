//
//  ContentView.swift
//  WeSplit
//
//  Created by Philipp on 22.12.2020.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 2
    let tipPercentages = [5, 10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let tipSelected = Double(tipPercentages[tipPercentage])
        let peopleCount = Double(numberOfPeople) ?? 1
        let orderAmount = Double(checkAmount) ?? 0
        return orderAmount * ((tipSelected / 100) + 1) / peopleCount
    }
    
    var totalAmount: Double {
        let tipSelected = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        return orderAmount * ((tipSelected / 100) + 1)
    }
    
    var isZeroTip: Bool {
        var zeroTip = false
        let tipSelected = Double(tipPercentages[tipPercentage])
        if tipSelected == 0 {
            zeroTip = true
        } else {
            zeroTip = false
        }
        return zeroTip
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Check amount: ", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    TextField("Number of people: ", text: $numberOfPeople)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip percentage: ", selection: $tipPercentage) {
                        ForEach (0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0]) %")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Total amount including tip")) {
                    Text("$\(totalAmount, specifier: "%.2f")")
                }
                
                Section(header: Text("Amount per person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
            }
            .navigationBarTitle(Text("WeSplit"))
            .foregroundColor(isZeroTip ? .red : .blue)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
