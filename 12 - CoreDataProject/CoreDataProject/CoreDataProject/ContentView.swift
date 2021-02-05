//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Philipp on 05.02.2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var moc
    @State var lastNameFilter = "A"
    
    var body: some View {
        VStack {
            withAnimation {
                FilteredList(filterKey: "lastName", filterValue: lastNameFilter, descriptors: []) { (singer: Singer) in
                    Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
                }
            }
            Button("Add Examples") {
                let taylor = Singer(context: self.moc)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"
                
                let ed = Singer(context: self.moc)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"
                
                let katy = Singer(context: self.moc)
                katy.firstName = "Katy"
                katy.lastName = "Perry"
                
                let ryan = Singer(context: self.moc)
                ryan.firstName = "Ryan"
                ryan.lastName = "Tedder"
                
                let adele = Singer(context: self.moc)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"
                
                try? self.moc.save()
            }
            
            HStack {
                Button("Show A") {
                    self.lastNameFilter = "A"
                }
                Button("Show S") {
                    self.lastNameFilter = "S"
                }
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
