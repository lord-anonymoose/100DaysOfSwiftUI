//
//  ContentView.swift
//  temperatureConverter
//
//  Created by Philipp on 24.12.2020.
//

import SwiftUI

struct ContentView: View {
    let scales = ["Celsius", "Fahrenheit", "Kelvin"]
    @State private var inputScale = 0
    @State private var outputScale = 0
    @State private var inputAmount = ""
    
    var outputAmount: Double {
        let startScale = scales[inputScale]
        let endScale = scales[outputScale]
        let amount = Double(inputAmount) ?? 0
        var result: Double = 0.0
        
        if (startScale == "Celsius" && endScale == "Fahrenheit") {
            result = (amount * 9 / 5) + 32 
        } else if (startScale == "Celsius" && endScale == "Kelvin") {
            result = amount + 273.15
        } else if (startScale == "Fahrenheit" && endScale == "Celsius") {
            result = (amount - 32) * 5 / 9
        } else if (startScale == "Fahrenheit" && endScale == "Kelvin") {
            result = ((amount - 32) * 5 / 9) - 273.15
        } else if (startScale == "Kelvin" && endScale == "Celsius") {
            result = amount - 273.15
        } else if (startScale == "Kelvin" && endScale == "Fahrenheit") {
            result = 9 / 5 * (amount - 273.15) + 32
        } else {
            result = amount
        }
        return result
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("From:")) {
                    TextField("Amount", text: $inputAmount)
                        .keyboardType(.decimalPad)
                    Picker ("Input scale: ", selection: $inputScale) {
                        ForEach (0..<scales.count) {
                            Text("\(scales[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("To:")) {
                    Picker ("Output scale: ", selection: $outputScale) {
                        ForEach (0..<scales.count) {
                            Text("\(scales[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Result:")) {
                    Text("\(outputAmount, specifier: "%.2f")")
                }
            }
            
            
            
                .navigationTitle("Temperature converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
