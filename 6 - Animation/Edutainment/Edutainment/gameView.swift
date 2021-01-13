//
//  gameView.swift
//  Edutainment
//
//  Created by Philipp on 13.01.2021.
//

import SwiftUI

struct gameView: View {
    @State private var answer = ""
    var body: some View {
        VStack {
            Text("2 x 2")
                .font(.headline)
            Text("=")
                .font(.headline)
            TextField("answer", text: $answer)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 70, alignment: .center)
            Button ("Check") {
                //Check the answer
            }
        }
    }
}

struct gameView_Previews: PreviewProvider {
    static var previews: some View {
        gameView()
    }
}
