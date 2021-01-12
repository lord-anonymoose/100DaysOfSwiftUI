//
//  ContentView.swift
//  iExpense
//
//  Created by Philipp on 11.01.2021.
//

import SwiftUI

struct expenseItem {
    let name: String
    let type: String
    let amount: Int
}

class Expenses: ObservableObject {
    @Published var items = [expenseItem]()
}

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items, id: \.name) { item in
                    Text(item.name)
                }
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(trailing:
                                    Button("Add") {
                                        let expense = expenseItem(name: "Expense", type: "Personal",
                                                                  amount: 1)
                                        self.expenses.items.append(expense)
                                    }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
