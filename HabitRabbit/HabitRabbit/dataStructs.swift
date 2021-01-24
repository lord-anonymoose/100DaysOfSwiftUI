//
//  dataStructs.swift
//  HabitRabbit
//
//  Created by Philipp on 24.01.2021.
//

import Foundation
import SwiftUI

struct Habit {
    var name: String
    var comments: String
    var last: Date
    var currentStreak: Int = 0
    var bestStreak: Int = 0
}


let addButton = Image(systemName: "plus")
