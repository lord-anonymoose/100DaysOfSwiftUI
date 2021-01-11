//
//  ContentView.swift
//  Edutainment
//
//  Created by Philipp on 10.01.2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var data = gameData()
    var body: some View {
        settingsView()
            .sheet(isPresented: $data.gameStarted) {
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
