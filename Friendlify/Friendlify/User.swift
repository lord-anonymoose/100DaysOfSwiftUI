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
    let id: String
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
    let friends: [Friend]
}

struct Friend: Codable {
    let id: String
    let name: String
}

let urlString = "https://www.hackingwithswift.com/samples/friendface.json"
