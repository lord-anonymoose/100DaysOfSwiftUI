//
//  customAnimations.swift
//  Animation
//
//  Created by Philipp on 07.01.2021.
//

import Foundation
import SwiftUI

struct implicitAnimation: View {
    @State private var animationAmount: CGFloat = 1
    var body: some View {
        Button("Tap me") {
            self.animationAmount += 1
        }
        .padding(50)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .scaleEffect(animationAmount)
    }
}

struct customAnimation: View {
    @State private var animationAmount: CGFloat = 1
    
    var body: some View {
        Button("Tap me") {
            self.animationAmount += 1
        }
        .padding(50)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        //.animation(.default) // Really smooth one
        // .animation(.easeOut) // Starts fast, slows down
        // .animation(.interpolatingString(stiffness: 50, damping: 1) // Bouncing effect
        // .animation(.easeInOut(duration:2)) // lasts 2 secs
        /*
         .animation(
            Animation.easeInOut(duration:2))
                .delay(1)
                .repeatCount(3, autoreveres: true)
                .repeatForever(autoreverses: true)
         )
         */
    }
}

struct bouncingAnimation: View {
    @State private var animationAmount: CGFloat = 1
    
    var body: some View {
        Button("Tap me") {
            self.animationAmount += 1
        }
        .padding(50)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .overlay(
           Circle()
               .stroke(Color.red)
               .scaleEffect(animationAmount)
               .opacity(Double(2 - animationAmount))
               .animation(
                   Animation.easeInOut(duration: 1)
                       .repeatForever(autoreverses: false)
               )
        )
        .onAppear {
           self.animationAmount = 2
        }
    }
}

struct bindingAnimation: View {
    @State private var animationAmount: CGFloat = 1
    
    var body: some View {
        print(animationAmount)
        return VStack {
            Stepper("Scale amount", value: $animationAmount.animation(), in: 1...10)
                .padding()
            Spacer()
            
            Button("Tap Me") {
                self.animationAmount += 1
            }
            .padding(40)
            .background(Color.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .scaleEffect(animationAmount)
        }
    }
}
