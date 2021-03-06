//
//  CheckoutView.swift
//  Cupcake Corner
//
//  Created by Philipp on 27.01.2021.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                ScrollView {
                    VStack {
                        Image("cupcakes")
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width)
                        
                        Text ("Your total is $\(self.order.cost, specifier: "%.2f")")
                        
                        Button("Place order") {
                            self.placeOrder()
                        }
                        .padding()
                    }
                }
            }
        }
        .navigationBarTitle("Check out", displayMode: .inline)
        .alert(isPresented: $showingConfirmation) {
            Alert(title: Text("Thank you!"), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    func placeOrder() {
        guard let encoded = try? JSONEncoder().encode(order) else {
            self.confirmationMessage = "Failed to encode order"
            self.showingConfirmation = true
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                self.confirmationMessage = "No data in response: \(error?.localizedDescription ?? "Unknown error")."
                self.showingConfirmation = true
                return
            }

            if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data) {
                self.confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
                self.showingConfirmation = true
            } else {
                self.confirmationMessage = "Invalid response from server"
                self.showingConfirmation = true
            }
        }.resume()
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
