//
//  AddView.swift
//  HabitRabbit
//
//  Created by Philipp on 24.01.2021.
//

// This view is shown when user is adding a new habit to his list

import SwiftUI

struct AddView: View {
    @State private var newHabit = Habit(name: "", comments: "")
    @State private var name: String = ""
    let userData = defaults.object(forKey: "userData") as? [Habit] ?? [Habit]()
    @State private var allHabits = [Habit]()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Habit name")) {
                    TextField("Jogging", text: $newHabit.name)
                }
                Section(header: Text("Description")) {
                    TextField("Brief comments", text: $newHabit.comments)
                }
                
            }
            .navigationBarTitle("New habit")
            .navigationBarItems(trailing: Button(action: {
                allHabits = userData
                allHabits.append(newHabit)
                defaults.set(allHabits, forKey: "userData")
            }) {
                addButton
            })
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
