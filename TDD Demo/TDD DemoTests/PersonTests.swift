//
//  PersonTests.swift
//  TDD DemoTests
//
//  Created by Hayden Boss on 6/3/25.
//

import XCTest
@testable import TDD_Demo

class PersonTests: XCTestCase {
    func testFullName() {
        let person = Person(firstName: "Hayden", lastName: "Boss", favoriteFood: "")
     
        XCTAssertEqual(person.fullName, "Hayden Boss")
    }
    
    func testFavoriteFood() {
        let person = Person(firstName: "Hayden", lastName: "Boss", favoriteFood: "Pizza")
        
        XCTAssertEqual(person.favoriteFood, "Pizza")
    }
}
