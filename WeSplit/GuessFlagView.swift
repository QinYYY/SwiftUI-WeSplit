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
                       flagTapped(number)
                    }label: {
                        Image(countries[number])
//                            .frame(maxWidth: .infinity)
                            .clipShape(.rect(cornerRadius: 10))
                            .shadow(radius: 5)
                            .padding()
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
        print("\(number)")
        if number == correctAnswer {
            scoresTitle = "Correct"
            alertMsg = "you get 30 points"
            totalScores += 30
        }else{
            scoresTitle = "Wrong"
            alertMsg = "you foolish"
        }
        showingAlert = true
            
    }
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    GuessFlagView()
}
