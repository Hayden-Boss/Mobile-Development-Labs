//
//  Dog.swift
//  API Project Part 2
//
//  Created by Hayden Boss on 5/28/25.
//

import Foundation

struct Dog: Identifiable {
    let id = UUID()
    var name: String = ""
    var imageURL: URL
}

struct DogResponse: Decodable {
    let message: String
    let status: String
}
