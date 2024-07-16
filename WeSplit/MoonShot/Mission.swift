//
//  Mission.swift
//  WeSplit
//
//  Created by QinY on 16/7/2024.
//

import Foundation



struct Mission:Codable,Identifiable {
    
    struct CrewRole: Codable {
        let name:String
        let role:String
    }
    
    let id:Int
    let launchDate:String?
    let crew:[CrewRole]
    let description:String
    
    
    var displayName:String {
        "Apollo \(id)"
    }
    
    var image:String {
        "apollo\(id)"
    }
}
