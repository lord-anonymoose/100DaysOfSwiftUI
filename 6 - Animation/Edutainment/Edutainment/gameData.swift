//
//  gameData.swift
//  Edutainment
//
//  Created by Philipp on 11.01.2021.
//

import Foundation

class gameData: ObservableObject {
    @Published var gameStarted = false
    @Published var practicedTable = 1
    @Published var questionOptions = [5, 10, 20, 0]
    @Published var questions = 5
}
