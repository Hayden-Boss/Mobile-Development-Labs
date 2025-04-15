//
//  Player.swift
//  Score Keeper
//
//  Created by Hayden Boss on 4/1/25.
//

import Foundation

struct Player {
    var name: String
    var score: Int
    var logo: String
    
}
enum SortOrder {
    case ascending
    case descending
}
enum WinnerControl {
    case lowest
    case highest
}
struct Sport {
    var title: String
    var players: [Player]
    var sportImage: String
    var leader: Player?
    var sortOrder: SortOrder
    var winnerControl: WinnerControl
}

