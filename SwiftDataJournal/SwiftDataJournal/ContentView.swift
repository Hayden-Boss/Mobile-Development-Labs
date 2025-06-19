//
//  ContentView.swift
//  SwiftDataJournal
//
//  Created by Hayden Boss on 6/5/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var journals: [Journal]
    
    var body: some View {
        NavigationSplitView {
            NavigationStack {
                List {
                    ForEach(journals) { journal in
                        NavigationLink(value: journal) {
                            Text("\(journal.journalName) (\(journal.entries.count))")
                        }
                    }
                    .onDelete(perform: deleteJournals)
                }
                .navigationDestination(for: Journal.self) { journal in
                    EntryView(journal: journal)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                    ToolbarItem {
                        NavigationLink {
                            AddJournalView()
                                .environment(\.modelContext, modelContext)
                        } label: {
                            Label("New Journal", systemImage: "plus")
                        }
                    }
                }
            }
        } detail: {
            Text("Select a journal to view its entries.")
        }
    }
    
    private func deleteJournals(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(journals[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Journal.self, Entry.self], inMemory: true)
}
