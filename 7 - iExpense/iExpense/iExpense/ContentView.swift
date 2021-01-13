//
//  ContentView.swift
//  iExpense
//
//  Created by Philipp on 11.01.2021.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Int
}

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try?
                encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }

    init () {
        if let items = UserDefaults.standard.data(forKey: "Items")
        {
            let decoder = JSONDecoder()
            
            if let decoded = try?
                decoder.decode([ExpenseItem].self, from: items) {
                self.items = decoded
                return
            }
        }
        
        self.items = []
    }
}

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    struct itemView: View {
        var name: String
        var type: String
        var amount: Int
        var body: some View {
            HStack {
                VStack(alignment: .leading) {
                    Text(name)
                        .font(.headline)
                    Text(type)
                }
                Spacer()
                Text("$\(amount)")
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items, id: \.id) { item in
                    if item.amount <= 10 {
                        itemView(name: item.name, type: item.type, amount: item.amount)
                            .foregroundColor(Color.green)
                    } else if item.amount <= 100 {
                        itemView(name: item.name, type: item.type, amount: item.amount)
                            .foregroundColor(Color.orange)
                    } else {
                        itemView(name: item.name, type: item.type, amount: item.amount)
                            .foregroundColor(Color.red)
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(leading:
                                        EditButton(),
                                trailing:
                                        Button(action: {
                                            self.showingAddExpense.toggle()
                                        }) {
                                            Image(systemName: "plus")
                                        }
            )
            .sheet(isPresented: $showingAddExpense) {
                addView(expenses: self.expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

