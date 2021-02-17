//
//  ContentView.swift
//  BucketList
//
//  Created by Philipp on 17.02.2021.
//

import SwiftUI

struct User: Identifiable, Comparable {
    let id = UUID()
    let firstName: String
    let lastName: String
    
    static func < (lhs: User, rhs: User) -> Bool {
        lhs.lastName < rhs.lastName
    }
}

struct ContentView: View {
    let users = [
        User(firstName: "Brian", lastName: "Wards"),
        User(firstName: "Robert", lastName: "Hunter"),
        User(firstName: "Kayla", lastName: "Alamdari"),
        User(firstName: "Cristina", lastName: "Sanz")
    ].sorted()
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    var body: some View {
        Text("Hello, World!")
            .onTapGesture {
                let str = "Test Message"
                let url = self.getDocumentsDirectory()
                    .appendingPathComponent("message.txt")
                do {
                    try str.write(to: url, atomically: true, encoding: .utf8)
                    let input = try String(contentsOf: url)
                    print(input)
                }
                catch {
                    print(error.localizedDescription)
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
