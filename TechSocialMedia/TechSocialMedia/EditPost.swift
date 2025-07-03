//
//  EditPost.swift
//  TechSocialMedia
//
//  Created by Hayden Boss on 7/1/25.
//

import SwiftUI

struct EditPost: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var title: String
    @State private var bodyText: String
    @State private var isSaving = false
    @State private var errorMessage: String?
    
    let post: Post
    let postController: PostController

    init(post: Post, postController: PostController) {
        self.post = post
        self.postController = postController
        _title = State(initialValue: post.title)
        _bodyText = State(initialValue: post.body)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Title")) {
                    TextField("Enter post title", text: $title)
                }
                Section(header: Text("Body")) {
                    TextEditor(text: $bodyText)
                        .frame(minHeight: 150)
                }
                if let errorMessage = errorMessage {
                    Section {
                        Text(errorMessage).foregroundColor(.red)
                    }
                }
            }
            .disabled(isSaving)
            .navigationTitle("Edit Post")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    if isSaving {
                        ProgressView()
                    } else {
                        Button("Save") {
                            savePost()
                        }
                        .disabled(title.isEmpty || bodyText.isEmpty)
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
                try await postController.editPost(post: post, updatedTitle: title, updatedBody: bodyText)
                await MainActor.run {
                    isSaving = false
                    dismiss()
                }
            } catch {
                await MainActor.run {
                    errorMessage = "Failed to save post. Please try again."
                    isSaving = false
                }
                print("Edit post error:", error)
            }
        }
    }
}

