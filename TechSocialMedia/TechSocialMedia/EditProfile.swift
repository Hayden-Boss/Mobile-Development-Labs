//
//  EditProfile.swift
//  TechSocialMedia
//
//  Created by Hayden Boss on 6/24/25.
//

import SwiftUI

struct EditProfile: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var bio: String = UserProfile.current?.bio ?? ""
    @State private var techInterests: String = UserProfile.current?.techInterests ?? ""
    @State private var isSaving = false
    @State private var errorMessage: String?

    let profileController = ProfileController()
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Bio")) {
                    TextEditor(text: $bio)
                        .frame(minHeight: 100)
                }

                Section(header: Text("Tech Interests")) {
                    TextEditor(text: $techInterests)
                        .frame(minHeight: 100)
                }

                if let errorMessage = errorMessage {
                    Section {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    }
                }
            }
            .disabled(isSaving)
            .navigationTitle("Edit Profile")
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
                            saveProfile()
                        }
                    }
                }
            }
        }
    }
    
    func saveProfile() {
        isSaving = true
        errorMessage = nil
        
        Task {
            do {
                // Assume updateProfile updates the current profile on server and returns the updated profile
                let updatedProfile = try await profileController.updateProfile(bio: bio, techInterests: techInterests)
                await MainActor.run {
                    UserProfile.current = updatedProfile
                    isSaving = false
                    dismiss()
                }
            } catch {
                await MainActor.run {
                    errorMessage = "Failed to save profile. Try again."
                    isSaving = false
                }
                print("save profile error:", error)
            }
        }
    }
}
