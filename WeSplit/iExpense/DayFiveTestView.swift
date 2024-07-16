//
//  DayFiveTestView.swift
//  WeSplit
//
//  Created by QinY on 11/7/2024.
//

import SwiftUI

struct DayFiveTestView: View {
    @State private var user = User()
    @State private var showingSheet = false
    
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    
    @State private var tapCount = UserDefaults.standard.integer(forKey: "tap")
    
    @AppStorage("tapCount") private var tapCount1 = 0
    func removeRows(at offset:IndexSet){
        numbers.remove(atOffsets: offset)
    }
    
    var body: some View {
        
        NavigationStack {
            VStack {
                List {
                    ForEach(numbers,id: \.self){
                        Text("row \($0)")
                    }
                    .onDelete(perform: { indexSet in
                        numbers.remove(atOffsets: indexSet)
                    })
                }
                
                Button("addNumber"){
                    numbers.append(currentNumber)
                    currentNumber += 1
                    tapCount1 += 1
                    UserDefaults.standard.set(currentNumber, forKey: "tap")
                }.customTextFieldStyle()
                
            }
            Form {
                
                
                Section {
                    Button("show sheet") {
                        showingSheet.toggle()
                        
                    }
                    .foregroundStyle(.white)
                    .padding(20)
                    .frame(minWidth: 200,minHeight: 50)
                    .background(.yellow)
                    .clipShape(.rect(cornerRadius: 10))
                    .sheet(isPresented: $showingSheet, content: {
                        SecondView(name: "YQ")
                    })
                }
                
                VStack {
                    
                    Text ("your name is \(user.firstName) \(user.lastName)")
                        .frame(width: 200,height: 50)
                        .background(Color.init(hex: "#71c9ce"))
                        .clipShape(.rect(cornerRadius: 5))
                        .padding(20)
                    
                    TextField("First name",text: $user.firstName)
                        .customTextFieldStyle()
                        
                    TextField("Last name",text: $user.lastName)
                        .customTextFieldStyle()
                    
                }
            }.toolbar{
                EditButton()
        }
        }
    }
}


struct SecondView:View {
    let name:String
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack{
            LinearGradient(colors: [.yellow,.mint], startPoint: .top, endPoint: .bottom)
            VStack{
                Spacer()
                Button("dismiss"){
                    dismiss()
                }
                Spacer()
                Text("hello,\(name)")
                Spacer()
            }
        }.ignoresSafeArea()
        
    }
}

@Observable
class User {
    
    var firstName = "Lishi"
    var lastName = "Cai"
}

struct customTextField:ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 300,height: 50)
//            .background(Color.init(hex: "#71c9ce"))
            .padding(20)
            .border(Color.init(hex: "#71c9ce"))
            .clipShape(.rect(cornerRadius: 10))
//            .foregroundStyle(.white)
            
    }
    
}
extension View {
    
    func customTextFieldStyle() -> some View{
        modifier(customTextField())
    }
    
}

#Preview {
    DayFiveTestView()
}
