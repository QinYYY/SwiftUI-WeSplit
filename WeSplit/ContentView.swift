//
//  ContentView.swift
//  WeSplit
//
//  Created by QinY on 1/7/2024.
//

import SwiftUI

struct ContentView: View {
    
    @FocusState private var amountIsFocused:Bool
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    
    
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
        
        
        TabView{
            NavigationStack{
                SplitView()
                
            }.tabItem { Label("WeSplit",systemImage: "pencil") }
            
            NavigationStack{
                GuessFlagView()
            }.tabItem { Label("GuessFlag", systemImage: "flag") }
            NavigationStack{
                BetterSleepView()
            }.tabItem { Label("BetterSleep",systemImage: "circle") }
            NavigationStack{
                WordScramble()
            }.tabItem { Label("WordScramble",systemImage: "4.circle") }
            NavigationStack{
                MoonShotView()
            }.tabItem { Label("MoonShot",systemImage: "5.circle") }
        }
    }
}

#Preview {
    ContentView()
}

            
