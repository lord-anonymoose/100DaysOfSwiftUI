//
//  ContentView.swift
//  Instafilter
//
//  Created by Philipp on 08.02.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var showingActionSheet = false
    @State private var backgroundColor = Color.white
    
    @State private var blurAmount: CGFloat = 0 {
        didSet {
            print("New value is \(blurAmount)")
        }
    }
    var body: some View {
        let blur = Binding<CGFloat>(
            get: {
                self.blurAmount
            },
            set: {
                self.blurAmount = $0
                print("New value is \(self.blurAmount)")
            }
        )
        
        Text("Hello, world \(blurAmount)!")
            .frame(width: 300, height: 300)
            .background(backgroundColor)
            .blur(radius: blurAmount)
            .onTapGesture {
                self.showingActionSheet = true
            }
            .actionSheet(isPresented: $showingActionSheet) {
                ActionSheet(title: Text("Change background"), message: Text("Choose color"), buttons: [
                    .default(Text("Red")) { self.backgroundColor = .red},
                    .default(Text("Green")) { self.backgroundColor = .green},
                    .default(Text("Blue")) { self.backgroundColor = .blue},
                    .cancel()
                ])
            }
        Slider(value: blur, in: 0...20)
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
