//
//  Dragon.swift
//  DragonDex
//
//  Created by Hayden Boss on 5/16/25.
//

import SwiftUI

struct Dragon: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let thumbnail: String
    let lore: String
    let powers: [String]
}


let sampleDragons = [
    Dragon(name: "Night Fury", thumbnail: "Night_Fury_Thumbnail", lore: "Very epic", powers: ["Fire Breath", "Flight", "Super Duper Speed"
    ]),
    Dragon(name: "Zippleback", thumbnail: "Zippleback_Thumbnail", lore: "I don't remember", powers: ["Fire Breath", "Flight", "Super Speed"]),
    Dragon(name: "Grug", thumbnail: "Grug_Thumbnail", lore: "Totally a dragon", powers: ["Family", "Anger", "Super Strength"]),
]
