//
//  IExpenseView.swift
//  WeSplit
//
//  Created by QinY on 11/7/2024.
//

import SwiftUI

struct ExpenseItem: Identifiable,Codable {
    let id = UUID()
    let name:String
    let type:String
    let amount:Double
}

@Observable
class Expenses {
    
    var items = [ExpenseItem]() {
        
        didSet {
            if let encoded = try?JSONEncoder().encode(items){
                UserDefaults.standard.set(encoded,forKey: "Items")
            }
        }
    }
    init(){
        if let savedItems = UserDefaults.standard.data(forKey: "Items"){
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems){
                items = decodedItems
                return
            }
        }
        items = []

    }
}

struct IExpenseView: View {
    
    @State private var showingAddExpense = false
    
    @State private var expenses = Expenses()
    
    func removeItems(at offsets:IndexSet){
        expenses.items.remove(atOffsets: offsets)
    }
    
    var body: some View {
        NavigationStack {
            List{
                
                ForEach(expenses.items,id: \.id) {item in
                    HStack {
                        VStack(alignment:.leading){
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        Text(item.amount,format:.currency(code:"USD"))
                    }
                }.onDelete(perform:removeItems(at:))
            }
            .navigationTitle("iExpense")
            .toolbar{
                    Button("Add Expense",systemImage: "plus"){
                        showingAddExpense = true
                    }
                }
            .sheet(isPresented: $showingAddExpense, content: {
                AddView(expenses: expenses)
            })
        }
    }
}



#Preview {
    IExpenseView()
}
