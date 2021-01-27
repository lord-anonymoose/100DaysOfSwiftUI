//
//  CheckoutView.swift
//  Cupcake Corner
//
//  Created by Philipp on 27.01.2021.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                    
                    Text ("Your total is $\(self.order.cost, specifier: "%.2f")")
                    
                    Button("Place order") {
                        //place order
                    }
                    .padding()
                }
            }
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
