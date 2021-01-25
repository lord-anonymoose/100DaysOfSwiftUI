//
//  HomeView.swift
//  HabitRabbit
//
//  Created by Philipp on 24.01.2021.
//

// This is the main view of the app

import SwiftUI


struct HomeView: View {
    
    @State private var showingAddView = false
    let userData = defaults.object(forKey: "userData") as? [Habit] ?? [Habit]()
    
    var body: some View {
        NavigationView {
            List(userData) {habit in
                Text("\(habit.name)")
            }
                .sheet(isPresented: $showingAddView) {
                    AddView()
                }
                .navigationBarTitle("My habits")
                .navigationBarItems(trailing:
                                        Button(action: {
                                            showingAddView.toggle()
                                        }) {
                                            addButton
                                        }
                )
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
