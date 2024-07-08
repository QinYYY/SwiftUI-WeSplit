//
//  DayThreeTestView.swift
//  WeSplit
//
//  Created by QinY on 8/7/2024.
//

import SwiftUI

struct DayThreeTestView: View {
    @State private var useRedText = false
    var body: some View {
        VStack{
            CapculeText(text: "11111").font(.largeTitle)
            CapculeText(text: "22222").blur(radius: 2)
            CapculeText(text: "44444")
//                .padding()
//                .background(.red)
//                .padding()
//                .background(.yellow)
//                .padding()
//                .background(.blue)
//                .padding()
//                .background(.green)
        }
        .frame(maxWidth: .infinity)
        .font(.title)
        .background(.mint)
        .blur(radius: 1)
        
        
        VStack{
            Button("tap"){
                useRedText.toggle()
            }
            .frame(width: 200,height: 200)
            .background(useRedText ? .red : .blue)
        }
        .waterMarked(with: "nihao")
        .frame(maxWidth: .infinity,minHeight: 300)
        .background(.gray)
        VStack {
            CustomGridView()
        }
        .background(.gray)
        
        
        
    }

}

struct CapculeText:View {
    var text:String
    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .foregroundStyle(.brown)
            .background(.white)
            .clipShape(.capsule)
    }
}

struct waterMarkView:ViewModifier {
    var text:String
    func body(content:Content) -> some View {
        ZStack(alignment: .bottomTrailing, content: {
            content
            Text(text)
                .font(.caption)
                .foregroundStyle(.white)
                .padding(5)
                .background(.black)
        })
        
    }
}

struct GridStack<Content:View>:View {
    let rows:Int
    let columns:Int
    @ViewBuilder let content:(Int,Int) -> Content
    
    var body: some View{
        VStack {
            ForEach(0..<rows,id: \.self){row in
                HStack {
                    ForEach(0..<columns,id: \.self){ column in
                        content(row,column)
                    }
                }
            }
        }
    }
}

struct CustomGridView:View {
    var body: some View{
        GridStack(rows: 4, columns: 4) { row, col in
            HStack{
                
                Image(systemName: "\(row*4 + col).circle")
                Text("R\(row) C\(col)")
                    .padding(5)
                    
            }.background(.red)
                .padding(2)
                .frame(maxWidth: .infinity)
            
        }.padding(5)
    }
}

struct LargeBlueTitle:ViewModifier {
    func body(content: Content) -> some View {
        ZStack{
            Text("large blue title")
                .font(.title)
                .foregroundStyle(.blue)
                .background(.red)
                .padding(10)
        }
    }
}


extension View {
    func waterMarked(with text:String) -> some View {
        
        modifier(waterMarkView(text: text))
    }
    
    func largeBlueView() -> some View {
        modifier(LargeBlueTitle())
    }
    
}

#Preview {
    DayThreeTestView()
}
