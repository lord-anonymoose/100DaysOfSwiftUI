//
//  ContentView.swift
//  Cupcake Corner
//
//  Created by Philipp on 26.01.2021.
//

import SwiftUI


struct ContentView: View {
    @ObservedObject var order = Order()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(0..<Order.types.count, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper(value: $order.quantity, in: 3...20) {
                        Text("\(order.quantity) cakes")
                    }
                    
                    Section {
                        Toggle(isOn: $order.specialRequestEnabled.animation()) {
                            Text("Any special requests?")
                        }
                    }
                    
                    if order.specialRequestEnabled {
                        Toggle(isOn: $order.extraFrosting) {
                            Text("Add extra frosting")
                        }
                        
                        Toggle(isOn: $order.addSprinkles) {
                            Text("Add sprinkles")
                        }
                    }
                    
                    Section {
                        NavigationLink(destination: AddressView(order: order)) {
                            Text("Delivery details")
                        }
                    }
                    
                }
                .navigationTitle("Cupcake corner")
            }
        }
    }
}
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
