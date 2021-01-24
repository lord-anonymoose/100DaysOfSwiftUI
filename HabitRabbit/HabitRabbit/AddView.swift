//
//  AddView.swift
//  HabitRabbit
//
//  Created by Philipp on 24.01.2021.
//

import SwiftUI

struct AddView: View {
    @State private var newHabit = Habit(name: "", comments: "", lastCheckIn: nil)
    @State private var name: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Habit name")) {
                    TextField("Jogging", text: $newHabit.name)
                }
                Section(header: Text("Description")) {
                    MultilineTextView(text: $newHabit.comments)
                        .frame(height: 50)
                }
                
            }
            .navigationBarTitle("New habit")
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
