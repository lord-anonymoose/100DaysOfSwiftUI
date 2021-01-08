//
//  ContentView.swift
//  Animation
//
//  Created by Philipp on 07.01.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount: CGFloat = 1
    
    var body: some View {
        transitionAnimation()
     }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
