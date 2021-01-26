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
    @State private var userData = loadData()
    
    func removeRows(at offsets: IndexSet) {
        userData.remove(atOffsets: offsets)
        saveData(habits: userData)
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(userData, id: \.id) { habit in
                    Text(habit.name)
                }
                .onDelete(perform: self.removeRows)
            }

            .onChange(of: showingAddView) {_ in
                userData = loadData()
            }
            
            .sheet(isPresented: $showingAddView) {
                AddView()
            }
                .navigationBarTitle("My habits")
                .navigationBarItems(
                    trailing:
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
