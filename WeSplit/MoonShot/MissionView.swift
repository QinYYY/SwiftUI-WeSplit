//
//  MissionView.swift
//  WeSplit
//
//  Created by QinY on 16/7/2024.
//

import SwiftUI

struct CrewMember {
    let role:String
    let astronaut:Astronaut
    
}
struct MissionView: View {
    let mission:Mission
    let crew:[CrewMember]
    
    init(mission: Mission,astonauts:[String:Astronaut]) {
        self.mission = mission
        self.crew = mission.crew.map {member in
            if let astonaut = astonauts[member.name]{
                return CrewMember(role: member.role, astronaut: astonaut)
            }else {
                fatalError("Missing \(member.name)")
            }
            
        }
    }
    
    var body: some View {
        
        ScrollView {
            VStack {
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal){width,axis in
                        width * 0.6
                        }
                    .padding(.top)
                
                VStack (alignment: .leading){
                    Rectangle()
                        .frame(height:2)
                        .foregroundStyle(.lightBackground)
                        .padding(.vertical)
                    Text("Crew")
                        .font(.title.bold())
                        .padding(.bottom,10)
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.bottom,5)
                    Text(mission.launchDate ?? "N/A")
                    Text(mission.description)
                }
                .padding(.horizontal)
                
                
                ScrollView (.horizontal,showsIndicators: false) {
                    HStack {
                        ForEach(crew,id:\.role){crewMember in
                            
                            NavigationLink{
                                AstronautView(astronaut: crewMember.astronaut)
                            } label:{
                                HStack {
                                    Image(crewMember.astronaut.id)
                                        .resizable()
                                        .frame(width:104,height: 72)
                                        .clipShape(.capsule)
                                        .overlay(Capsule().strokeBorder( .white,lineWidth:1))
                                    VStack(alignment: .leading) {
                                        Text(crewMember.astronaut.name)
                                            .foregroundStyle(.white)
                                            .font(.headline)

                                        Text(crewMember.role)
                                            .foregroundStyle(.white.opacity(0.5))
                                    }
                                }
                                .padding(.horizontal)
                            }
                            
                        }
                    }
                }
                
            }
            .padding(.bottom,10)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
}

#Preview {
    let missions:[Mission] = Bundle.main.decode("missions.json")
    let astronauts:[String:Astronaut] = Bundle.main.decode("astronauts.json")
    return MissionView(mission: missions[0],astonauts: astronauts)
        .preferredColorScheme(.dark)
}
