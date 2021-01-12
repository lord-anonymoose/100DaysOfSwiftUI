//
//  gameView.swift
//  Edutainment
//
//  Created by Philipp on 12.01.2021.
//

import SwiftUI

struct gameView: View {
    @ObservedObject var data = gameData()

    var body: some View {
        Text("\(data.questions) and \(data.practicedTable)")
    }
}

struct gameView_Previews: PreviewProvider {
    static var previews: some View {
        gameView()
    }
}
