//
//  DayFourTestView.swift
//  WeSplit
//
//  Created by QinY on 9/7/2024.
//

import SwiftUI

struct DayFourTestView: View {
    
    let people = ["Tom","Jerry","Bluce","Jack"]
    
    
    @State private var animationAmount = 1.0
    
    @State private var animationAmount1 = 0.0
    
    @State private var buttonEanbled = false
    
    @State private var dragAmount = CGSize.zero
    
    @State private var isShowingRectangle = false
    
    let letters = Array("Hello SwiftUI")
    
    var body: some View {
        
        
        
        List{
            
            Section {
                VStack {
                    Button("tap") {
                        withAnimation{
                            isShowingRectangle.toggle()
                        }
                    }
                    .frame(width: 100,height: 50)
                    .background(.orange)
                    .clipShape(.rect(cornerRadius: 10))
                    
                    if isShowingRectangle {
                        Rectangle()
                            .fill(.indigo)
                            .frame(width: 200,height: 200)
                            .clipShape(.rect(cornerRadius: 20))
//                            .transition(.asymmetric(insertion: .scale, removal: .opacity))
                            .transition(.pivot)
                    }
                }
            }.frame(minHeight: 200)
            
            
            Section{
                HStack(spacing:0) {
                    
                    ForEach(0..<letters.count,id: \.self){ num in
                        
                        Text(String(letters[num]))
                            .padding(5)
                            .font(.title)
                            .background(buttonEanbled ? .purple : .cyan)
                            .offset(dragAmount)
                            .animation(.linear.delay(Double(num)), value: dragAmount)
                            
                    }
                }.gesture(
                    DragGesture()
                        .onChanged{
                            dragAmount = $0.translation
                        }
                        .onEnded{ _ in
                            dragAmount = .zero
                            buttonEanbled.toggle()
                            
                        }
                    
                )
                .frame(minHeight: 200)
            }
            
            
            Section{
                VStack{
                    LinearGradient(colors: [.yellow,.pink], startPoint: .topLeading, endPoint: .bottomTrailing)
                        .frame(width: 300,height: 300)
                        .clipShape(.rect(cornerRadius: 20))
                        .offset(dragAmount)
                        .padding(200)
                        .gesture(
                        DragGesture()
                            .onChanged{dragAmount = $0.translation}
                            .onEnded{_ in
                                withAnimation(.bouncy){
                                    dragAmount = .zero
                                }
                            })
            //            .animation(.bouncy, value: dragAmount)
                }
            }
            
            Section("section one"){
                
                Button("button1"){
                    buttonEanbled.toggle()
                }
                .frame(width: 200,height: 200)
                .background(buttonEanbled ? .yellow : .mint)
                .animation(nil, value: buttonEanbled)
                .foregroundStyle(.white)
                .clipShape(.rect(cornerRadius: buttonEanbled ? 60 : 20))
//                .animation(.default, value: buttonEanbled)
                .animation(.spring(duration: 1,bounce: 0.6),value: buttonEanbled)
                
                
            }
            Section("section two"){
                
                ForEach (people,id:\.self){
                    Text($0)
                }
            }
            
            Section("animation") {
                HStack {
                    Button("tap"){
                        
                        if animationAmount < 5 {
                            animationAmount += 1
                        }else{
                            animationAmount = 1
                        }
                    }
                    .padding(50)
                    .background(.red)
                    .foregroundStyle(.white)
                    .clipShape(.circle)
                    .blur(radius: (animationAmount - 1)*3)
                    .scaleEffect(animationAmount)
                    .animation(.spring(duration: 1,bounce: 0.9), value: animationAmount)
                    Spacer()
                    Button("tap"){
                        
                        if animationAmount < 5 {
                            animationAmount += 1
                        }else{
                            animationAmount = 1
                        }
                    }
                    .padding(50)
                    .background(.red)
                    .foregroundStyle(.white)
                    .clipShape(.circle)
                    .overlay(
                        Circle()
                            .stroke(.red)
                            .scaleEffect(animationAmount)
                            .opacity(2-animationAmount)
                            .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: animationAmount)
                    ).onAppear{
                        animationAmount = 2
                    }
                    
                    .frame(minHeight: 300)
                }
                
            }
            
            Section (""){
                VStack {
                    Stepper("scale amount", value: $animationAmount.animation(), in: 1...5)
                    Spacer()
                    Button("tap"){
                        if animationAmount < 3 {
                            animationAmount += 1
                        }else{
                            animationAmount = 1
                        }
                    }
                    .padding(40)
                    .background(.green)
                    .foregroundStyle(.white)
                    .clipShape(Circle())
                    .scaleEffect(animationAmount)
                    .frame(minHeight: 200,alignment: .center)
                }
            }
            Section ("23"){
                
                VStack{
                    
                    Button("tap"){
                        
                        withAnimation(.spring(duration: 1,bounce: 0.5)){
                            animationAmount1 += 360
                        }
                    }
                    .padding(40)
                    .background(.brown)
                    .foregroundStyle(.white)
                    .clipShape(Circle())
                    .frame(minHeight: 200)
                    .rotation3DEffect(
                        .degrees(animationAmount1),
                                              axis: (x: 0.0, y: 1.0, z: 0.0)
                    )
                }
            }
        }.listStyle(.grouped)
    }
}


struct CornerRotateModifier:ViewModifier {
    
    let amount:Double
    let anchor:UnitPoint
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount),anchor: anchor)
            .clipped()
    }
    
}

extension AnyTransition {
    static var pivot:AnyTransition {
        .modifier(active: CornerRotateModifier(amount: -90, anchor: .topLeading), identity: CornerRotateModifier(amount: 0, anchor: .topLeading))
    }
}

#Preview {
    DayFourTestView()
}
