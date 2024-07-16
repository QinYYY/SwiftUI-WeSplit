//
//  MoonShot.swift
//  WeSplit
//
//  Created by QinY on 12/7/2024.
//

import SwiftUI

struct Astronaut:Codable,Identifiable {
    let id:String
    let name:String
    let description:String
}

struct MissionLabel{
    let mission:Mission
    var body:some View{
        VStack {
            Image(mission.image)
                .resizable()
                .scaledToFit()
                .frame(width:100,height: 100)
            
            VStack {
                Text(mission.displayName)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(5)
                
                Text(mission.launchDate ?? "N/A")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.5))
            }
            .padding(.vertical)
            .frame(maxWidth: .infinity)
            .background(.lightBackground)
            
        }
        .clipShape(.rect(cornerRadius: 10))
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(.lightBackground))
        .padding([.horizontal,.bottom])
    }
}



struct MoonShotView: View {
    
    @State private var buttonTitle:String = "List"
    @State private var showList = true
    
    var body: some View {
        
        let astronauts:[String:Astronaut] = Bundle.main.decode("astronauts.json")
        
        let missions:[Mission] = Bundle.main.decode("missions.json")
        
        let testData = ["2","3","4"]
        
        let columns = [
            GridItem(.adaptive(minimum: 150))
        ]
        
        NavigationStack {
            ScrollView {
                
                if showList {
                    LazyVStack{
                        ForEach(missions) { mission in
                            
                            NavigationLink{
                                MissionView(mission: mission, astonauts: astronauts)
                            }label :{
                                
                                VStack {
                                    Image(mission.image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width:100,height: 100)
                                    
                                    VStack {
                                        Text(mission.displayName)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                            .padding(5)
                                        
                                        Text(mission.launchDate ?? "N/A")
                                            .font(.caption)
                                            .foregroundColor(.white.opacity(0.5))
                                    }
                                    .padding(.vertical)
                                    .frame(maxWidth: .infinity)
                                    .background(.lightBackground)
                                    
                                }
                                .clipShape(.rect(cornerRadius: 10))
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(.lightBackground))
                                .padding([.horizontal,.bottom])
                                
                            }
                        }
                    }
                } else {
                    LazyVGrid(columns: columns){
                        
                        ForEach(missions) { mission in
                            NavigationLink{
                                MissionView(mission: mission, astonauts: astronauts)
                            }label :{
                                VStack {
                                    Image(mission.image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width:100,height: 100)
                                    
                                    VStack {
                                        Text(mission.displayName)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                            .padding(5)
                                        
                                        Text(mission.launchDate ?? "N/A")
                                            .font(.caption)
                                            .foregroundColor(.white.opacity(0.5))
                                    }
                                    .padding(.vertical)
                                    .frame(maxWidth: .infinity)
                                    .background(.lightBackground)
                                    
                                }
                                .clipShape(.rect(cornerRadius: 10))
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(.lightBackground))
                                .padding([.horizontal,.bottom])
                                
                            }
                        }
                    }
                }
            }
            .navigationTitle("Monnshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar{
                Button(showList ? "List" : "Grid"){
                    showList.toggle()
                }
            }
        }
    }
    func showData(_ missions:[Mission], astonauts: [String:Astronaut]){
        ForEach(missions) { mission in
            NavigationLink{
                MissionView(mission: mission, astonauts: astonauts)
            }label :{
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width:100,height: 100)
                    
                    VStack {
                        Text(mission.displayName)
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(5)
                        
                        Text(mission.launchDate ?? "N/A")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.5))
                    }
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(.lightBackground)
                    
                }
                .clipShape(.rect(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(.lightBackground))
                .padding([.horizontal,.bottom])
                
            }
        }
    }
    
}



#Preview {
    MoonShotView()
}
