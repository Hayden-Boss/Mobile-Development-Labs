//
//  AddJournalView.swift
//  SwiftDataJournal
//
//  Created by Hayden Boss on 6/10/25.
//

import SwiftUI
import SwiftData

struct AddJournalView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var journalName = ""
    
    var body: some View {
        Form {
            TextField("Journal Name", text: $journalName)
        }
        .navigationTitle("New Journal")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    let newJournal = Journal(journalName: journalName, entries: [])
                    modelContext.insert(newJournal)
                    dismiss()
                }
            }
            ToolbarItem(placement: .cancellationAction) {
            }
        }
    }
}
