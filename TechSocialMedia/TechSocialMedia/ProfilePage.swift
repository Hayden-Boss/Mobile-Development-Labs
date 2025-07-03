//
//  ProfilePage.swift
//  TechSocialMedia
//
//  Created by Hayden Boss on 6/23/25.
//

import SwiftUI

struct ProfilePage: View {
    @State private var isShowingEditProfile = false
    @State private var isShowingEditPost: Bool = false
    @State private var selectedPost: Post?
    @State private var posts: [Post] = []

    let postController = PostController()
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

                    Divider()

                    Text("My Posts")
                        .font(.headline)
                        .padding(.top)

                    ForEach(posts, id: \.postid) { post in
                        PostView(post: post)
                        .padding(.vertical, 8)
                    }
                }
                .padding()
            }
            .onAppear {
                fetchMyPosts()
            }
            .sheet(isPresented: $isShowingEditPost, onDismiss: {
                fetchMyPosts()
            }, content: {
                if let postToEdit = selectedPost {
                    EditPost(post: postToEdit, postController: postController)
                }
            })
        } else {
            VStack {
                ProgressView()
                Text("Loading profile...")
            }
        }
    }
    
    func menuButton(forPost post: Post) -> some View {
        Menu {
            // edit button
            Button {
                selectedPost = post
                isShowingEditPost = true
            } label: {
                Text("Edit Post")
            }
            // delete button
            Button(role: .destructive) {
                Task {
                    do {
                        try await postController.deletePost(postid: String(post.postid))
                        await MainActor.run {
                            posts.removeAll { $0.postid == post.postid }
                        }
                    } catch {
                        print("Delete failed:", error)
                    }
                }
            } label: {
                Text("Delete Post")
            }
            
        } label: {
            Image(systemName: "ellipsis")
        }
    }
    
    func PostView(post: Post) -> some View {
    VStack(alignment: .leading, spacing: 8) {
    HStack {
        Text(post.authorUserName)
        Spacer()
        if post.authorUserName == User.current?.userName ?? "" {
            menuButton(forPost: post)
        }
    }
    Text(post.title).bold()
    Text(post.body)
        HStack {
            Image(systemName: "heart")
                .font(.system(size: 20))
            Text("(\(post.likes))")
            Spacer()
            Image(systemName: "bubble.right")
                .font(.system(size: 20))
                .foregroundColor(.gray)
                .padding(.leading, 12)
            Text(post.numComments.description)
            Spacer()
            Text(post.createdDate)
        }
    }
}
    
    func fetchMyPosts() {
        Task {
            do {
                self.posts = try await postController.getUserPosts()
            } catch {
                print(error)
            }
        }
    }
}
