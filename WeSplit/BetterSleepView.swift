//
//  BetterSleepView.swift
//  WeSplit
//
//  Created by QinY on 9/7/2024.
//

import SwiftUI
import CoreML
struct BetterSleepView: View {
    
    static var defaultWakeTime:Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    @State private var wakeup = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 0
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                LinearGradient(colors: [Color.init(hex: "#46cdcf"),Color.init(hex: "#8785a2")], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
                Form {
                    
                    Section("when do you want to wake up") {
                        
                        DatePicker("please enter a time",selection: $wakeup,displayedComponents: .hourAndMinute)
                            .labelsHidden()
                            .titleFontStyle()
                            
                            
                    }
                    .customBackColor()
                    .customCorner()
                    
                    Section("Desired amount of sleep") {
//                        Text("Desired amount of sleep")
//                            .padding(10)
                        Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12,step: 0.25)
                            .padding(10)
                            
                    }.customBackColor()
                     .customCorner()
                    
                    Section("Daily coffee intake") {
//                        Text("Daily coffee intake")
//                            .padding(10)
//                        Stepper(coffeeAmount > 1 ?  "\(coffeeAmount) cups":"\(coffeeAmount) cup", value: $coffeeAmount, in: 0...10)
//                            .padding(20)
//                        Stepper("^[\(coffeeAmount) cup](inflect:true)", value: $coffeeAmount, in: 0...10)
//                            .padding(10)
//MARK: - challenge
                        Picker("^[\(coffeeAmount) cup](inflect:true)",selection: $coffeeAmount){
                            ForEach (0..<11) { item in
                                Text("\(item)")
                            }
                            
                        }
                            
                    }.customBackColor().customCorner()
                    
                }
                .scrollContentBackground(.hidden)
                .titleFontStyle()
                .alert(alertTitle, isPresented: $showingAlert) {
                    Button("ok"){
                            
                    }
                } message: {
                    Text(alertMessage)
                }

                
            }.navigationTitle("BetterSleep")
                .toolbar{
                       Button("Calculate",action: calculatorBedTime)
                        .titleFontStyle()
                        }
        }
        
    }
    
    func calculatorBedTime(){
        print("22")
        
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            let components = Calendar.current.dateComponents([.hour,.minute], from: wakeup)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeup - prediction.actualSleep
            
            alertTitle = "Your ideal bedtime is..."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            
        }catch {
            alertTitle = "Error"
            alertMessage = "Sorry,there was a preoblem calculating your bedtime."
            showingAlert = true
        }
        showingAlert = true
    }
    
}




//MARK: - custom font for title
struct titleFont:ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 22))
            .fontWeight(.bold)
            .foregroundStyle(Color.init(hex: "#3f72af", alpha: 1))
    }
}

struct backColor:ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color.init(hex: "#3f72af", alpha: 0))
    }
}

struct radiusCorner:ViewModifier {
    func body(content: Content) -> some View {
        content
            .clipShape(.rect(cornerRadius: 10))
    }
}

extension View {
    func titleFontStyle() -> some View {
        modifier(titleFont())
    }
    
    func customBackColor() -> some View {
        modifier(backColor())
    }
    func customCorner() -> some View {
        modifier(radiusCorner())
    }
}


#Preview {
    BetterSleepView()
}


