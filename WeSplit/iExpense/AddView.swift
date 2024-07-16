//
//  AddView.swift
//  WeSplit
//
//  Created by QinY on 11/7/2024.
//

import SwiftUI

struct AddView: View {
    
    @State private var name = ""
    @State private var type = "psesonal"
    @State private var amount = 0.0
    
    let types = ["Business","Personal"]
    
    var expenses:Expenses
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name",text: $name)
                Picker("TYPE",selection: $type){
                    ForEach(types,id: \.self){
                        Text($0)
                    }
                }
                TextField("Amount",value: $amount,format:.currency(code: "USD")).keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .toolbar{
                Button("Save"){
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(item)
                    dismiss()
                }.customButtonStyle()
            }
            
        }
    }
}

struct buttonStyle1:ViewModifier{
    func body(content: Content) -> some View {
        content
            .padding(10)
            .background(.red)
            .clipShape(.rect(cornerRadius: 10))
            .foregroundStyle(.white)
        
    }
}

extension View {
    
    func customButtonStyle() -> some View{
        
        modifier(buttonStyle1())
    }
    
}

#Preview {
    AddView(expenses: Expenses())
}
