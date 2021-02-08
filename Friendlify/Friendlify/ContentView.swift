//
//  ContentView.swift
//  Friendlify
//
//  Created by Philipp on 06.02.2021.
//

import SwiftUI
import CoreData

extension Bundle {
    func decode(_ file: String) -> [User] {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()

        guard let loaded = try? decoder.decode([User].self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }

        return loaded
    }
}

struct ContentView: View {
    @State var results = [User]()
    
    var body: some View {
        List(results, id: \.id) { user in
            Text(user.name)
        }
        .onAppear(perform: loadData)
    }
    
    func loadData () {
        //results = Bundle.main.decode("friendface.json")
        do {
            guard let url = URL(string: urlString) else {
                print("Invalid URL")
                return
            }
            
            let request = URLRequest(url: url)

            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            URLSession.shared.dataTask(with: request) {
                data, responce, error in
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .iso8601
                        self.results = try decoder.decode([User].self, from: data)
                        // your code
                    } catch {
                        print("Decode error:", error)
                        return
                    }
                } else {
                    print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
                }
            }.resume()
        }
        /*
            let users = try decoder.decode([User].self, from: data)
        } catch {
            print("Decode error:", error)
            return
        }
 */
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
