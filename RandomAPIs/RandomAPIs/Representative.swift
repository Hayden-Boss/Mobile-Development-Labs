//
//  Representative.swift
//  RandomAPIs
//
//  Created by Hayden Boss on 5/2/25.
//

import Foundation

struct Representative: Codable {
    let name: String
    let state: String
    let party: String
    let district: String
    let link: String

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case state = "state"
        case party = "party"
        case link = "link"
        case district = "district"
    }
}

struct RepResponse: Codable {
    let results: [Representative]
}
