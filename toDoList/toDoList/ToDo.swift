//
//  ToDo.swift
//  toDoList
//
//  Created by Hayden Boss on 4/15/25.
//

import Foundation

struct ToDo: Equatable, Codable {
    var title: String
    var isComplete: Bool
    var dueDate: Date
    var notes: String?
    
    static func saveToDos(_ toDos: [ToDo]) {
        let propertyListEncoder = PropertyListEncoder()
        let codedToDos = try? propertyListEncoder.encode(toDos)
        try? codedToDos?.write(to: archiveURL, options: .noFileProtection)
    }
    
    static func loadToDos() -> [ToDo]? {
        guard let codedToDos = try? Data(contentsOf: archiveURL) else {return nil}
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode([ToDo].self, from: codedToDos)
    }
    
    static func loadSampleToDos() -> [ToDo] {
        let ToDo1 = ToDo(title: "Buy milk", isComplete: false, dueDate: Date(), notes: "Notes 1")
        let ToDo2 = ToDo(title: "Learn SwiftUI", isComplete: false, dueDate: Date(), notes: "Notes 2")
        let ToDo3 = ToDo(title: "Go for a walk", isComplete: false, dueDate: Date(), notes: "Notes 3")
        
        return [ToDo1, ToDo2, ToDo3]
    }
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("toDos").appendingPathExtension("plist")
}


