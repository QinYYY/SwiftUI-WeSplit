//
//  TestView.swift
//  WeSplit
//
//  Created by QinY on 3/7/2024.
//

import SwiftUI

struct TestView: View {
    let array = ["one","two","three"]
    @State private var number = "one"
    @State private var tapCount = 0
    @State private var name = ""
    
    
    var body: some View {
//        day one
        NavigationStack{
            Form{
                Text("this is a form")
                Section{
                    Text("this is a section")
                }
                Section{
                    Text("this is a section")
                    Text("this is a section")
                }
                Section{
                    Button("tapCount\(tapCount)") {
                        self.tapCount += 1
                    }
                }
                Section{
                    TextField("enter your name", text: $name)
                    Text("your name is \(name)")
                }
                Section{
                    Picker("选择你的号码",selection: $number){
                       
                        ForEach(array,id:\.self){
                            Text("\($0)")
                        }
                    }
                }
            }
            .navigationTitle("SwiftUI")
            .navigationBarTitleDisplayMode(.automatic)
        }
        
//        day two
        
    }
    
}

#Preview {
    TestView()
}
