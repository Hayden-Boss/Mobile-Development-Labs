////
////  delete.swift
////  TechSocialMedia
////
////  Created by Hayden Boss on 6/30/25.
////
//
//import Foundation
////
////  PostPage.swift
////  TechSocialMedia
////
////  Created by Hayden Boss on 6/23/25.
////
//
//import SwiftUI
//
//struct PostPage: View {
//    let postController = PostController()
//    @State var posts = [Post]()
//    
//    var body: some View {
//        NavigationStack {
//            List {
//                ForEach(posts.indices, id: \.self) { index in
//                    let post = posts[index]
//                    VStack {
//                        Text(post.authorUserName)
//                        Text(post.title)
//                        Text(post.body)
//                        HStack {
//                            HeartButton(
//                                isLiked: $posts[index].userLiked, postid: Int(post.postid), postController: postController
//                            )
//                            Text("(\(post.likes))")
//                            Spacer()
//                            Image(systemName: "bubble.right")
//                                .font(.system(size: 20))
//                                .foregroundColor(.gray)
//                                .padding(.leading, 12)
//                            Text(post.numComments.description)
//                            Spacer()
//                            Text(post.createdDate)
//                        }
//                    }
//                }
//                .onAppear {
//                    fetchPosts()
//                }
//                .refreshable {
//                    fetchPosts()
//                }
//                .navigationTitle("Posts")
//                .toolbar {
//                    ToolbarItem(placement: .navigationBarTrailing) {
//                        NavigationLink(destination: CreateNewPost()) {
//                            Image(systemName: "plus")
//                        }
//                    }
//                }
//            }
//        }
//    }
//    
//    func fetchPosts() {
//        Task {
//            do {
//                self.posts = try await postController.getPosts()
//            } catch {
//                print(error)
//            }
//        }
//    }
//    struct HeartButton: View {
//        @Binding var isLiked: Bool
//        let postid: Int
//        let postController: PostController
//
//        var body: some View {
//            Button {
//                Task {
//                    await toggleLike()
//                }
//            } label: {
//                Image(systemName: isLiked ? "heart.fill" : "heart")
//                    .foregroundColor(isLiked ? .red : .gray)
//                    .font(.system(size: 24))
//                    .scaleEffect(isLiked ? 1.2 : 1.0)
//                    .animation(.easeInOut(duration: 0.2), value: isLiked)
//            }
//        }
//
//        private func toggleLike() async {
//            isLiked.toggle()
//            do {
//                _ = try await postController.updateLikes(for: postid)
//            } catch {
//                print(error)
//                await MainActor.run {
//                    isLiked.toggle() // revert on failure
//                }
//            }
//        }
//    }
//}
