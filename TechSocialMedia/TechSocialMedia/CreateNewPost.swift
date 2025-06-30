//
//  CreateNewPost.swift
//  TechSocialMedia
//
//  Created by Hayden Boss on 6/24/25.
//

import SwiftUI

import SwiftUI

struct CreateNewPost: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var title: String = ""
    @State private var textBody: String = ""
    @State private var isSaving = false
    @State private var errorMessage: String?
    
    let postController = PostController()
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Title")) {
                    TextField("Enter post title", text: $title)
                }
                
                Section(header: Text("Body")) {
                    TextEditor(text: $textBody)
                        .frame(minHeight: 150)
                }
                
                if let errorMessage = errorMessage {
                    Section {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    }
                }
            }
            .disabled(isSaving)
            .navigationTitle("New Post")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if isSaving {
                        ProgressView()
                    } else {
                        Button("Save") {
                            savePost()
                        }
                        .disabled(title.isEmpty || textBody.isEmpty)
                    }
                }
            }
        }
    }
    
    func savePost() {
        isSaving = true
        errorMessage = nil
        
        Task {
            do {
                try await postController.createPost(title: title, body: textBody)
                await MainActor.run {
                    isSaving = false
                    dismiss()
                }
            } catch {
                await MainActor.run {
                    errorMessage = "Failed to save post. Please try again."
                    isSaving = false
                }
                print("Create post error:", error)
            }
        }
    }
}
