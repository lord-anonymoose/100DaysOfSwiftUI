//
//  ContentView.swift
//  Drawing
//
//  Created by Philipp on 18.01.2021.
//

import SwiftUI

struct Arrow: Shape {
    func path(in rect: CGRect) -> Path {
        var triangle = Path()
        var line = Path()
        
        line.move(to: CGPoint(x:rect.midX, y: rect.midY))
        line.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))

        
        triangle.move(to: CGPoint(x: rect.midX, y: rect.midY - 20))
        triangle.addLine(to: CGPoint(x: rect.midX + 20, y: rect.midY))
        triangle.addLine(to: CGPoint(x: rect.midX - 20, y: rect.midY))
        triangle.addLine(to: CGPoint(x: rect.midX, y: rect.midY - 20))
        
        var arrow = line
        arrow.addPath(triangle)
        return arrow
    }
    
}

struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x:rect.midX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        
        return path
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX - 20, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.midY - 20))
        path.addLine(to: CGPoint(x: rect.midX + 20, y: rect.midY))
        return path
    }
}

struct ContentView: View {
    @State private var lineWidth: CGFloat = 3

    var animatableData: CGFloat {
        get { lineWidth }
        set { self.lineWidth = newValue }
    }
    
    var body: some View {
        Arrow()
            .stroke(Color.red, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
            .onTapGesture {
                withAnimation {
                    lineWidth += 10
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
