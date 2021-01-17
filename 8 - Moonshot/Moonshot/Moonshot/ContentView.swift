//
//  ContentView.swift
//  Moonshot
//
//  Created by Philipp on 14.01.2021.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    @State private var showingDate = true
    @State private var buttonText = "Show crew"
    
    var body: some View {
        NavigationView {
            List(missions) {mission in
                NavigationLink(
                    destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        if showingDate {
                            Text(mission.formattedLaunchDate)
                        } else {
                            Text(mission.crewMates.joined(separator: ", "))
                        }
                    }
                }
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing: Button(buttonText) {
                showingDate.toggle()
                if showingDate {
                    buttonText = "Show crew"
                } else {
                    buttonText = "Show dates"
                }
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
