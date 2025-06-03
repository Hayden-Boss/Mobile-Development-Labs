//
//  Person.swift
//  TDD Demo
//
//  Created by Hayden Boss on 6/3/25.
//

import Foundation

class Person {
    var firstName: String
    var lastName: String
    var favoriteFood: String
    
    init(firstName: String, lastName: String, favoriteFood: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.favoriteFood = favoriteFood
    }
    
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
}
