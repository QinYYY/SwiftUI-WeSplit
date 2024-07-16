//
//  DaySixView.swift
//  WeSplit
//
//  Created by QinY on 12/7/2024.
//

import SwiftUI

struct People:Codable{
    let name:String
    let address:Address
    
    
}
struct Address:Codable{
    let street:String
    let city:String
}

struct DaySixView: View {
    var body: some View {
        
        
        NavigationStack {
            
            
            let layout = [GridItem(.adaptive(minimum: 80, maximum: 120))]
//            [GridItem(.fixed(80)),GridItem(.fixed(80)),GridItem(.fixed(80))]
            ScrollView(.horizontal) {
                LazyHGrid(rows:layout){
                    ForEach(0..<1000){
                        Text("item\($0)")
                    }
                }
            }
            
            
            Button("tap"){
                let input = """
                {
                "name":"Taylor Swift",
                "address":{
                    "street":"555,taylor swift Ave"
                    "city":"Adelaide"
                    }
                    
                }
            """
                let data = Data(input.utf8)
                let decoder = JSONDecoder()
                if let people = try? decoder.decode(People.self, from: data){
                    print(people.address.street)
                }
                print("1")
            }
            
            List (0..<100){ row in
                NavigationLink{
                    Text("Detail View")
                } label:{
                    VStack {
                        Text("This is the label")
                        Text("So is this")
                        Image(systemName: "face.smiling")
                    }
                    .font(.largeTitle)
                }
                
            }
            
//            ScrollView(.horizontal){
//                LazyVStack(spacing:10) {
//                    
//                    ForEach(0..<10){item in
//                        
//                        Text("text \(item)")
//                        
//                    }.frame(maxWidth:.infinity)
//                    
//                Image("cloud")
//        //            .clipShape(.rect(radius:10))
//        //            .resizable()
//                    .scaledToFit()
//        //            .frame(width: 300, height: 300, alignment: .center)
//                    .containerRelativeFrame(.horizontal){size,axis in
//                        size * 0.8
//                        
//                    }
//                    .background(.red)
//                    .clipped()
//                    
//                }
//            }
        }
    }
}

#Preview {
    DaySixView()
}
