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

struct rotatingAnimation: View {
    @State private var animationAmount = 0.0
    var body: some View {
        Button("Tap me") {
            withAnimation {
                self.animationAmount += 360
            }
        }
        .padding(50)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y:1, z:0))
    }
}

struct dragAnimation: View {
    @State private var dragAmount: CGSize = .zero
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .frame(width: 300, height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .offset(dragAmount)
            .gesture (
                DragGesture()
                    .onChanged { self.dragAmount = $0.translation }
                    .onEnded { _ in
                        withAnimation (.spring()) {
                            self.dragAmount = .zero }
                    }
            )
    }
}

struct snakeEffect: View {
    @State private var dragAmount: CGSize = .zero
    let letters = Array("Hello, world!")
    @State private var enabled = false
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<letters.count) { num in
                Text(String(self.letters[num]))
                    .padding(5)
                    .font(.title)
                    .background(self.enabled ? Color.blue : Color.red)
                    .offset(self.dragAmount)
                    .animation(Animation.default.delay(Double(num) / 20))
            }
        }
        .gesture(
            DragGesture()
                .onChanged { self.dragAmount = $0.translation }
                .onEnded { _ in
                    self.dragAmount = .zero
                    self.enabled.toggle()
                }
        )
        
    }
}

struct transitionAnimation: View {
    @State private var isShowingRed = false
    var body: some View {
        VStack {
            Button("Tap me") {
                withAnimation {
                    self.isShowingRed.toggle()
                }
            }
            
            if isShowingRed {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 200, height: 200)
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
            }
        }
    }
}
