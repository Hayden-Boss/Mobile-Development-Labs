//
//  PostPage.swift
//  TechSocialMedia
//
//  Created by Hayden Boss on 6/23/25.
//

import SwiftUI

struct PostPage: View {
    let postController = PostController()
    @State var posts = [Post]()

    var body: some View {
        NavigationStack {
            List(posts, id: \.postid) { post in
                VStack {
                    Text(post.authorUserName)
                    Text(post.title)
                    Text(post.body)
                    HStack {
                        HeartButton()
                        Text("(\(post.likes))")
                        Spacer()
                        Image(systemName: "bubble.right")
                                .font(.system(size: 20))
                                .foregroundColor(.gray)
                                .padding(.leading, 12)
                        Spacer()
                        Text(post.createdDate)
                    }
                }
            }
            .onAppear {
                fetchPosts()
            }
            .refreshable {
                fetchPosts()
            }
            .navigationTitle("Posts")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: CreateNewPost()) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
    
    func fetchPosts() {
        Task {
            do {
                self.posts = try await postController.getPosts()
            } catch {
                print(error)
            }
        }
    }
    struct HeartButton: View {
        @State private var isLiked = false

        var body: some View {
            Button(action: {
                isLiked.toggle()
            }) {
                Image(systemName: isLiked ? "heart.fill" : "heart")
                    .foregroundColor(isLiked ? .red : .gray)
                    .font(.system(size: 24))
                    .scaleEffect(isLiked ? 1.2 : 1.0)
                    .animation(.easeInOut(duration: 0.2), value: isLiked)
            }
        }
    }
}
