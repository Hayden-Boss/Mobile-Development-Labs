//
//  Entry.swift
//  SwiftDataJournal
//
//  Created by Hayden Boss on 6/5/25.
//

import SwiftUI
import SwiftData

@Model
class Entry: Identifiable {
    var id: UUID
    var title: String
    var body: String
    var createdAt: Date
    var updatedAt: Date?
    var journal: Journal?
    
    init(title: String, body: String, journal: Journal) {
        self.id = UUID()
        self.title = title
        self.body = body
        self.createdAt = Date()
        self.journal = journal
    }
}
