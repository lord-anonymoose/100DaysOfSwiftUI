//
//  ContentView.swift
//  Friendlify
//
//  Created by Philipp on 06.02.2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State var results = [User]()
    
    var body: some View {
        List(results, id: \.id) { user in
            Text(user.name)
        }
        .onAppear(perform: loadData)
    }
    
    func loadData () {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                    DispatchQueue.main.async {
                        self.results = decodedResponse.results
                    }
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
