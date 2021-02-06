//
//  FriendlifyApp.swift
//  Friendlify
//
//  Created by Philipp on 06.02.2021.
//

import SwiftUI

@main
struct FriendlifyApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
