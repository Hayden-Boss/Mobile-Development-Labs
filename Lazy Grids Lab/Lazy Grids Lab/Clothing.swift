//
//  Clothing.swift
//  Lazy Grids Lab
//
//  Created by Hayden Boss on 6/2/25.
//

import Foundation

struct Clothing: Hashable, Identifiable {
    let id = UUID()
    let name: String
    let price: Double
    let size: String
    let color: String
}
