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



struct MoonShotView: View {
    var body: some View {
        
        
        let astronauts:[String:Astronaut] = Bundle.main.decode("astronauts.json")
        
        let missions:[Mission] = Bundle.main.decode("missions.json")
        
        let columns = [
            GridItem(.adaptive(minimum: 150))
        ]
        
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns){
                    
                    ForEach(missions) { mission in
                        NavigationLink{
                            Text("Detail View")
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
            .navigationTitle("Monnshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
        }
        
        
        
    }
}

#Preview {
    MoonShotView()
}
