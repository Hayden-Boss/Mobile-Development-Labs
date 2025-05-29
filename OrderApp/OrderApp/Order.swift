//
//  Order.swift
//  OrderApp
//
//  Created by Hayden Boss on 5/9/25.
//

import Foundation

struct Order: Codable {
    var menuItems: [MenuItem]
    
    init(menuItems: [MenuItem] = []) {
        self.menuItems = menuItems
    }
}
