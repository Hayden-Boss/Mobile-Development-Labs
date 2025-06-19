//
//  EntryView.swift
//  SwiftDataJournal
//
//  Created by Hayden Boss on 6/10/25.
//


import SwiftUI
import SwiftData

struct EntryView: View {
    @Environment(\.modelContext) private var modelContext
    var journal: Journal
    
    @State private var isShowingAddEntry = false
    
    var body: some View {
        List {
            ForEach(journal.entries) { entry in
                NavigationLink {
                    AddEditEntryView(entry: entry, journal: journal)
                } label: {
                    Text(entry.updatedAt ?? entry.createdAt, format: Date.FormatStyle(date: .numeric, time: .standard))
                }
            }
            .onDelete(perform: deleteItems)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem {
                NavigationLink {AddEditEntryView(journal: journal)} label: {
                    Label("Add Item", systemImage: "plus")
                }
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(journal.entries[index])
            }
        }
    }
}

#Preview {
    EntryView(journal: Journal(journalName: "Preview", entries: []))
        .modelContainer(for: Entry.self, inMemory: true)
}
