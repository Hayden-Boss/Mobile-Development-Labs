//
//  StoreItem.swift
//  iTunesSearch
//
//  Created by Hayden Boss on 4/29/25.
//

import Foundation

struct StoreItem: Codable {
    var trackName: String?
    var artistName: String?
    var kind: String?
    var trackCount: Int?
    var artworkURL: URL?
    
    enum CodingKeys: String, CodingKey {
        case trackName = "trackName"
        case artistName = "artistName"
        case kind
        case trackCount = "trackCount"
        case artworkURL = "artworkUrl100"
    }
}

struct SearchResponse: Codable {
    var results: [StoreItem]
}
