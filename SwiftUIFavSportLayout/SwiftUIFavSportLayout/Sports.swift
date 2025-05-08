//
//  Sports.swift
//  SwiftUIFavSportLayout
//
//  Created by Hayden Boss on 5/6/25.
//

import Foundation

struct Sport: Identifiable, Equatable {
    let id: UUID = UUID()
    var name: String
}

extension Sport {
    static var dummySports: [Sport] {
        return [
            .init(name: "Golf"),
            .init(name: "Football"),
            .init(name: "Soccer"),
            .init(name: "Baseball"),
        ]
    }
}
