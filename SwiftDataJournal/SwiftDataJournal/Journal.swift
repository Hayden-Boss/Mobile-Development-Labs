//
//  Journal.swift
//  SwiftDataJournal
//
//  Created by Hayden Boss on 6/10/25.
//

import SwiftUI
import SwiftData

@Model
class Journal: Identifiable {
    var id: UUID
    var journalName: String
    
    @Relationship(deleteRule: .cascade, inverse: \Entry.journal)
    var entries: [Entry]
    
    init(journalName: String, entries: [Entry]) {
        self.id = UUID()
        self.journalName = journalName
        self.entries = entries
    }
    
}
