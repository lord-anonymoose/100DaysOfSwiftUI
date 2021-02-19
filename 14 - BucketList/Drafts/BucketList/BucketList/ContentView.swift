//
//  ContentView.swift
//  BucketList
//
//  Created by Philipp on 17.02.2021.
//

import LocalAuthentication
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
    @State private var isUnlocked = false
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data."
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        
                    }
                }
            }
        } else {
            // no biometrics
        }
    }
    
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
        if self.isUnlocked {
            MapView()
        } else {
            Text("Locked")
        }
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
            .onAppear(perform: authenticate)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
