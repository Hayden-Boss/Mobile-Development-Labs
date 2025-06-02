//
//  Profiles.swift
//  GeometryReader Lab
//
//  Created by Hayden Boss on 5/29/25.
//

import Foundation

struct Profile: Identifiable {
    let id = UUID()
    var name: String
    var description: String
    var image: String
}

let profiles = [
    Profile(name: "Square", description: "A square is a quadrilateral with four equal sides.", image: "square"),
    Profile(name: "Rectangle", description: "A rectangle has four right angles.", image: "rectangle"),
    Profile(name: "Triangle", description: "A triangle has three sides.", image: "triangle"),
    Profile(name: "Circle", description: "A circle is round.", image: "circle"),
    Profile(name: "Hexagon", description: "A hexagon has six sides.", image: "hexagon"),
    Profile(name: "Pentagon", description: "A pentagon has five sides.", image: "pentagon"),
    Profile(name: "Octagon", description: "An octagon has eight sides.", image: "octagon")
]
