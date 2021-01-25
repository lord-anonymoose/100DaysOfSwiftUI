//
//  dataStructs.swift
//  HabitRabbit
//
//  Created by Philipp on 24.01.2021.
//

import Foundation
import SwiftUI
import Combine

let defaults = UserDefaults.standard

struct Habit: Identifiable, Codable {
    var id = UUID()
    
    var name: String
    var comments: String
    //var lastCheckIn: String?
    //var currentStreak: Int = 0
    //var bestStreak: Int = 0
}


let addButton = Image(systemName: "plus")
