//
//  Bundle.swift
//  BucketList
//
//  Created by Philipp on 17.02.2021.
//

import Foundation

extension FileManager {
    func decode(string: String, _ url: URL) {
        do {
            try string.write(to: url, atomically: true, encoding: .utf8)
            let input = try String(contentsOf: url)
            print(input)
        }
        catch {
            print(error.localizedDescription)
        }
    }
}
