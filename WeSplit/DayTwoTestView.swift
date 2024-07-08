//
//  DayTwoTestView.swift
//  WeSplit
//
//  Created by QinY on 4/7/2024.
//

import SwiftUI

struct DayTwoTestView: View {
    @State private var showingAlert = false
    var body: some View {
        ZStack{
            Color.green
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .foregroundStyle(.primary).padding(100)
                .background(.ultraThinMaterial)
                .background(.red.gradient)
            VStack(spacing:100){
                Color.blue
                Color.yellow
                
                Button("button1"){
                    print("click")
                }
                    .frame(minHeight: 20)
                    .border(.red, width: 2)
                    .buttonStyle(.bordered)
                    .background(.red)
                Button("button2",role: .cancel){
                    print("click2")
                }
                    .frame(minHeight: 20)
                    .border(.red, width: 2)
                    .buttonStyle(.bordered)
                    .background(.yellow)
                    .tint(.mint)
                Button{
                    print("BUTTON3")
                } label: {
                    Text("TAPME")
                        .padding()
                        .foregroundStyle(.white)
                        .background(.yellow)
                        .border(.bar)
                        .clipShape(.buttonBorder)
                    
                    
                }
                Button{
                    showingAlert = true
                } label: {
                    Label("tap",systemImage: "pencil")
                        .padding()
                        .background(.blue)
                        .foregroundColor(.white)
                        .clipShape(Capsule(), style: FillStyle())
                    
                }.alert("Hint", isPresented: $showingAlert) {
                    Button("not ok"){
                        
                    }
                }message: {
                    Text("read this message")
                }
                
            }
        }.ignoresSafeArea()
    }
}

#Preview {
    DayTwoTestView()
}
