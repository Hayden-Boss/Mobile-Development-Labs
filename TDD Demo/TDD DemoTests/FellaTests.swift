//
//  FellaTests.swift
//  TDD DemoTests
//
//  Created by Hayden Boss on 6/3/25.
//

import XCTest
@testable import TDD_Demo

class FellaTests: XCTestCase {
    
    func testAge() {
        let smella = Fella(name: "Heebs", age: 22, isSingle: true)
        
        XCTAssertLessThanOrEqual(smella.age, 25)
    }
    
    func testAgeAgain() {
        let smella = Fella(name: "Heebs", age: 22, isSingle: true)
        
        XCTAssertLessThanOrEqual(smella.age, 22)
    }
    
    func testShock() {
        let shock = "This guys name is \(example.name)?"
        XCTAssertEqual(shock, "This guys name is Hayden?")
    }
}
