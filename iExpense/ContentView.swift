//
//  ContentView.swift
//  iExpense
//
//  Created by Andrei Korikov on 29.07.2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        
                        Spacer()
                        Text("$\(item.amount)")
                            .foregroundColor(item.amount < 10 ? .gray : item.amount < 100 ? .black : .red)
                    }
                }
                .onDelete(perform: removeItem)
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                showingAddExpense = true
            }, label: {
                Image(systemName: "plus")
            }))
        }
        .sheet(isPresented: $showingAddExpense, content: {
            AddView(expenses: self.expenses)
        })
    }
    
    func removeItem(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
