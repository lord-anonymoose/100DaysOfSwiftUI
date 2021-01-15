//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Philipp on 15.01.2021.
//

import Foundation

extension Bundle {
    func decode<T: Codable>(_ file: String) -> T {
        
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to load data from \(file) in bundle")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load data from \(file) in bundle")
        }
        
        let decoder = JSONDecoder()
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to load data from \(file) in bundle")
        }
        
        return loaded
    }
}
