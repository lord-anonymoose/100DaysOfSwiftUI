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

func loadData() -> [Habit] {
    guard let userData = defaults.data(forKey: "userData") else { return [] }
    var result = try? JSONDecoder().decode([Habit].self, from: userData)
    if result == nil {
        result = [Habit]()
    }
    return result!
}

func saveData(habits : [Habit]) {
    guard let data = try? JSONEncoder().encode(habits) else { return }
    defaults.set(data, forKey: "userData")
}

struct Habit: Identifiable, Codable {
    var id = UUID()
    
    var name: String
    var comments: String
    //var lastCheckIn: String?
    //var currentStreak: Int = 0
    //var bestStreak: Int = 0
}


let addButton = Image(systemName: "plus")
