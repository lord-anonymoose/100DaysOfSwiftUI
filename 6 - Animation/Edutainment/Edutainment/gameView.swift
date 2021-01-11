//
//  gameView.swift
//  Edutainment
//
//  Created by Philipp on 10.01.2021.
//

import SwiftUI

struct gameView: View {
    var questions: Int
    var practicedTable: Int
    @State private var turns = 0
    var body: some View {
        Text("\(questions) and \(practicedTable)")
    }
}

