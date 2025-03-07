//
//  SplitView.swift
//  WeSplit
//
//  Created by QinY on 4/7/2024.
//

import SwiftUI

struct SplitView: View {
    
    @FocusState private var amountIsFocused:Bool
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    
    var useRedText:Bool {
        let isRed = tipPercentage == 0 ? true : false
        return isRed
    }
    
    let tipPercentages = [10,15,20,25,0]
    
    
    
    var totapPerPerson:Double {
        let peopleCount = Double(numberOfPeople+2)
        let tipSelection = Double(tipPercentage)
        let tipvalue = checkAmount * tipSelection / 100
        let grandTotal = checkAmount + tipvalue
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    var body: some View {
        NavigationStack{
            Form {
                Section("how much money on the bill"){

                    TextField("Amount",value: $checkAmount,format:.currency(code:Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                }


                Section("how many people do you have"){
                    Picker("numberOfPeople",selection: $numberOfPeople){
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }.pickerStyle(.navigationLink)
                }



                Section("how much tip do you wang to leave?"){
                    Picker("Tip percentage",selection: $tipPercentage){
                        ForEach(tipPercentages,id:\.self){ item in
                            Text(item,format:.percent)
                        }
                    }.pickerStyle(.segmented)
                }

                Section("how much money should pay"){
                    Text(totapPerPerson,format:.currency(code:Locale.current.currency?.identifier ?? "USD"))
                        .foregroundStyle(useRedText ? .red : .black)
                }
                Section("how much money each one should pay"){
                    Text(totapPerPerson,format:.currency(code:Locale.current.currency?.identifier ?? "USD"))
                }
            }
        }.navigationTitle("WeSplit").toolbar{
            if amountIsFocused{
                Button("Done"){
                    amountIsFocused = false
                }
            }
        }
    }
}

#Preview {
    SplitView()
}
