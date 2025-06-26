//
//  ProfilePage.swift
//  TechSocialMedia
//
//  Created by Hayden Boss on 6/23/25.
//

import SwiftUI

struct ProfilePage: View {
    @State private var isShowingEditProfile = false

    var user: User? { User.current }
    var userProfile: UserProfile? { UserProfile.current }

    var body: some View {
        if let user = user, let profile = userProfile {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ZStack {
                        Text(user.userName)
                            .font(.largeTitle)
                            .bold()

                        HStack {
                            Spacer()
                            Button {
                                isShowingEditProfile = true
                            } label: {
                                Image(systemName: "pencil")
                                    .imageScale(.large)
                            }
                        }
                    }

                    Text("\(user.firstName) \(user.lastName)")
                        .font(.title3)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Bio:")
                            .font(.headline)
                        Text(profile.bio)

                        Text("Tech Interests:")
                            .font(.headline)
                        Text(profile.techInterests)
                    }

                    Spacer()
                }
                .padding()
            }
            .sheet(isPresented: $isShowingEditProfile) {
                EditProfile()
            }
        } else {
            VStack {
                ProgressView()
                Text("Loading profile...")
            }
        }
    }
}


#Preview {
    (ProfilePage())
}
