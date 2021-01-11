//
//  gameView.swift
//  Edutainment
//
//  Created by Philipp on 10.01.2021.
//

import SwiftUI

struct gameView: View {
    @ObservedObject private var data = gameData()
    
    var body: some View {
        Text("\(data.questions) and \(data.practicedTable)")
    }
}

