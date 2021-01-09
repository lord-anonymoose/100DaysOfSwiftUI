//
//  flagView.swift
//  GuessTheFlag
//
//  Created by Philipp on 09.01.2021.
//

import Foundation
import SwiftUI

struct flagView: View {
    var image = ""
    var body: some View {
        Image(image)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black
                    , radius: 2)
    }
}
