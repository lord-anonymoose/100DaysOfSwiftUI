//
//  addView.swift
//  iExpense
//
//  Created by Philipp on 12.01.2021.
//

import SwiftUI

struct addView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    
    @State private var showingAlert = false
    
    @ObservedObject var expenses: Expenses
    
    static let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach (Self.types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("amount", text: $amount)
            }
            .navigationBarTitle("Add new item")
            .navigationBarItems(trailing:
                                    Button("Save") {
                                        if let actualAmount = Int(self.amount) {
                                            let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                                            self.expenses.items.append(item)
                                            self.presentationMode.wrappedValue.dismiss()
                                        }
                                        else {
                                            showingAlert = true
                                        }
                                    }
            )
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Oops!"), message: Text("Item amount is not a valid integer!"), dismissButton: .default(Text("Continue")))
            }
        }
    }
}

struct addView_Previews: PreviewProvider {
    static var previews: some View {
        addView(expenses: Expenses())
    }
}
