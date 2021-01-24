//
//  dataStructs.swift
//  HabitRabbit
//
//  Created by Philipp on 24.01.2021.
//

import Foundation
import SwiftUI
import Combine

struct Habit {
    var name: String
    var comments: String
    var lastCheckIn: Date?
    var currentStreak: Int = 0
    var bestStreak: Int = 0
}


let addButton = Image(systemName: "plus")


struct MultilineTextView: UIViewRepresentable {
    @Binding var text: String

    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.isScrollEnabled = true
        view.isEditable = true
        view.isUserInteractionEnabled = true
        return view
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
}
