//
//  AddEditEntryView.swift
//  SwiftDataJournal
//
//  Created by Hayden Boss on 6/6/25.
//

import SwiftUI

struct AddEditEntryView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var title: String = ""
    @State private var bodyText: String = ""
    @State var entry: Entry?
    var journal: Journal
    
    var body: some View {
        VStack {
            Text("Title")
                .font(.headline)
            TextField("Enter Title", text: $title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Text("Body")
                .font(.headline)
            TextEditor(text: $bodyText)
                .frame(height: 300)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity( 0.5)))
                .padding(.horizontal)
            
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    if let existingEntry = entry {
                        existingEntry.title = title
                        existingEntry.body = bodyText
                        existingEntry.updatedAt = Date()
                    } else {
                        let newEntry = Entry(title: title, body: bodyText, journal: journal)
                        newEntry.title = title
                        newEntry.body = bodyText
                        modelContext.insert(newEntry)
                        try? modelContext.save()
                    }
                    dismiss()
                }
            }
        }
        .onAppear {
            if let entry = entry {
                self.title = entry.title
                self.bodyText = entry.body
            }
        }
    }
}

#Preview {
    AddEditEntryView(journal: Journal(journalName: "Test", entries: []))
}
