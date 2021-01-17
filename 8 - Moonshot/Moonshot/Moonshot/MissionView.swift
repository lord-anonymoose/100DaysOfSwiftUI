//
//  MissionView.swift
//  Moonshot
//
//  Created by Philipp on 16.01.2021.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }

    let mission: Mission
    let astronauts: [CrewMember]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.7)
                        .padding(.top)
                    Text(self.mission.formattedLaunchDate)
                        .font(.headline)
                        .padding(.bottom)
                    Text(self.mission.description)
                        .padding()
                    
                    Spacer(minLength: 25)
                    
                    ForEach(self.astronauts, id: \.role) { CrewMember in
                        NavigationLink(
                            destination: AstronautView(astronaut: CrewMember.astronaut)) {
                                    HStack {
                                        Image(CrewMember.astronaut.id)
                                            .resizable()
                                            .frame(width: 83, height: 60)
                                            .clipShape(Capsule())
                                            .overlay(Capsule().stroke(Color.primary, lineWidth: 1))
                                        VStack(alignment: .leading) {
                                            Text(CrewMember.astronaut.name)
                                                .font(.headline)
                                            Text(CrewMember.role)
                                                .foregroundColor(.secondary)
                                        }
                                        
                                        Spacer()
                                    }
                            }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(.horizontal)
            
                }
            }
        }
        .navigationBarTitle(Text(self.mission.displayName), displayMode: .inline)
    }
    
    init(mission: Mission, astronauts: [Astronaut]) {
        self.mission = mission
        
        var matches = [CrewMember]()
        
        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id == member.name}) {
                matches.append(CrewMember(role: member.role, astronaut: match))
            } else {
                fatalError("Missing '(member)")
            }
        }
        
        self.astronauts = matches
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
    }
}
