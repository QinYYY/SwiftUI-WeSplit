//
//  GuessFlagView.swift
//  WeSplit
//
//  Created by QinY on 4/7/2024.
//

import SwiftUI

struct GuessFlagView: View {
    
    @State private var showingAlert = false
    
    @State private var countries = ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var totalScores = 0
    @State private var scoresTitle = ""
    @State private var alertMsg = ""
    
    @State private var degrees = 0.0
    
    @State private var tappedButton :Int? = nil
    @State private var opacity = 1.0
    @State private var opacity1 = 0.25
    
    
    var body: some View {
        
        ZStack{
            LinearGradient(colors: [.blue,.pink], startPoint: .top, endPoint: .bottom)
            VStack(spacing:15){
                VStack(spacing:10){
                    Text("Guess the Flag of")
                        .foregroundStyle(.white)
                        .font(.system(size: 24))
                        .font(.largeTitle.weight(.semibold))
                    Text(countries[correctAnswer])
                        .foregroundStyle(.white)
                        .font(.system(size: 30))
                        .fontWeight(.heavy)
                    Text("Your scores is \(totalScores)").foregroundStyle(.white)
                }
                ForEach(0..<3){number in
                    Button{
                        
                        tappedButton = number
                            
                    //MARK: - challenge
                        withAnimation(.spring(duration: 1,bounce: 0.8)){
                            if let tappedButton = tappedButton {
                                degrees += 360
                            }else{
                                opacity = 0.25
                            }
                        }
                        
                       flagTapped(number)
                    }label: {
                        Image(countries[number])
//                            .frame(maxWidth: .infinity)
                            .clipShape(.rect(cornerRadius: 10))
                            .shadow(radius: 5)
                            .padding()
                        //MARK: - challenge
                            .rotation3DEffect(
                                .degrees(tappedButton == number ? degrees : 0),axis: (x: 0.0, y: 1.0, z: 0.0))
                            .opacity(tappedButton == nil || tappedButton == number ? 1.0 : 0.25)
                            .animation(.easeInOut(duration: 1), value:tappedButton)
                        
                            
                    }
                    .alert(scoresTitle, isPresented: $showingAlert){
                        Button("Continue",action: askQuestion)
                    } message: {
                        Text(alertMsg)
                    }
                    
                    
                }
                .frame(maxWidth: .infinity)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
            }
                
            
        }.ignoresSafeArea()
    }
    func flagTapped(_ number :Int){

        print(number)
        
        if number == correctAnswer {
            scoresTitle = "Correct"
            alertMsg = "you get 30 points"
            totalScores += 30
        }else{
            scoresTitle = "Wrong"
            alertMsg = "you foolish"
        }
        showingAlert = true
        degrees = 0
        
    }
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    GuessFlagView()
}
