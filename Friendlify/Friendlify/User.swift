//
//  User.swift
//  Friendlify
//
//  Created by Philipp on 06.02.2021.
//

import Foundation

struct Response: Codable {
    var results: [User]
}

struct User: Codable {
    struct Friend: Codable {
        var id: String
        var name: String
    }
    
    var id: String
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var regiestered: Date
    var tags: [String]
    var friends: [Friend]
}

let urlString = "https://www.hackingwithswift.com/samples/friendface.json"
