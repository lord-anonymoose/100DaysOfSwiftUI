//
//  ContentView.swift
//  Edutainment
//
//  Created by Philipp on 10.01.2021.
//

import SwiftUI

struct ContentView: View {
    //@ObservedObject var data = gameData()
    //@EnvironmentObject var data: gameDate
    @ObservedObject var data = gameData()
    var body: some View {
        if (!data.gameStarted) {
            settingsView()
        } else {
            gameView()
        }
}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
