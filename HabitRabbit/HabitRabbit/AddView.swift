//
//  AddView.swift
//  HabitRabbit
//
//  Created by Philipp on 24.01.2021.
//

import SwiftUI

struct AddView: View {
    var body: some View {
        NavigationView {
            Form {
                Text("Hello, world!")
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
