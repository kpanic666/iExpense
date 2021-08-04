//
//  AddView.swift
//  iExpense
//
//  Created by Andrei Korikov on 04.08.2021.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var expenses: Expenses
    @State private var name = ""
    @State private var type = types.randomElement() ?? ""
    @State private var amount = ""
    @State private var amountAlert = false
    
    static let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add new expense")
            .navigationBarItems(trailing: Button("Save") {
                if let actualAmount = Int(amount) {
                    let item = ExpenseItem(name: name, type: type, amount: actualAmount)
                    expenses.items.append(item)
                    presentationMode.wrappedValue.dismiss()
                } else {
                    amountAlert = true
                }
            })
            .alert(isPresented: $amountAlert) {
                Alert(title: Text("Only numbers can be entered in the \"Amount\" field"))
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
            
    }
}
