//
//  MenuItem.swift
//  OrderApp
//
//  Created by Hayden Boss on 5/9/25.
//

import Foundation
import UIKit

struct MenuItem: Codable {
    var id: Int
    var name: String
    var detailText: String
    var price: Double
    var category: String
    var imageURL: URL
    var image: UIImage?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case detailText = "description"
        case price
        case category
        case imageURL = "image_url"
    }
}
