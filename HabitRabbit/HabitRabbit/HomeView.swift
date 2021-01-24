//
//  HomeView.swift
//  HabitRabbit
//
//  Created by Philipp on 24.01.2021.
//

import SwiftUI

struct HomeView: View {
    @State private var showingAddView = false
    
    var body: some View {
        NavigationView {
            List {

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
