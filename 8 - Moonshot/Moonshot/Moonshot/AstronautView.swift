//
//  AstronautView.swift
//  Moonshot
//
//  Created by Philipp on 16.01.2021.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let missions: [String]
    
    var allMissions: [Mission] = Bundle.main.decode("missions.json")

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    Text(self.astronaut.description)
                        .padding()
                    Text("Missions")
                        .font(.headline)
                    List {
                        ForEach (missions, id: \.self) {mission in
                            Text(mission)
                        }
                    }
                }
            }
        }
        .navigationTitle(Text(astronaut.name))
    }
    
    init(astronaut: Astronaut, missions: [Mission]) {
        self.astronaut = astronaut
        
        var matches = [String]()
                
        for i in missions {
            if i.crewMates.contains(astronaut.id.capitalizingFirstLetter()) {
                matches.append(i.displayName)
            }
        }
        self.missions = matches
    }
}

struct AstronautView_Previews: PreviewProvider {
    static var astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    //static var allMissions: [Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[0], missions: [Mission]())
    }
}
