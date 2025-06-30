import SwiftUI

struct PostPage: View {
    let postController = PostController()
    @State var posts = [Post]()
    @State private var currentPage = 0
    @State private var isLoadingMore: Bool = false
    @State private var allPostsLoaded: Bool = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(posts, id: \.postid) { post in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(post.authorUserName)
                        Text(post.title).bold()
                        Text(post.body)
                        HStack {
                            if let index = posts.firstIndex(where: { $0.postid == post.postid }) {
                                HeartButton(
                                    isLiked: $posts[index].userLiked,
                                    postid: post.postid,
                                    postController: postController
                                )
                            }
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
                    .padding(.vertical, 8)
                }

                if !allPostsLoaded {
                    HStack {
                        Spacer()
                        if isLoadingMore {
                            ProgressView()
                        } else {
                            Button("Load More") {
                                loadMorePosts()
                            }
                        }
                        Spacer()
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
        @Binding var isLiked: Bool
        let postid: Int
        let postController: PostController

        var body: some View {
            Button {
                Task {
                    await toggleLike()
                }
            } label: {
                Image(systemName: isLiked ? "heart.fill" : "heart")
                    .foregroundColor(isLiked ? .red : .gray)
                    .font(.system(size: 24))
                    .scaleEffect(isLiked ? 1.2 : 1.0)
                    .animation(.easeInOut(duration: 0.2), value: isLiked)
            }
        }

        private func toggleLike() async {
            isLiked.toggle()
            do {
                _ = try await postController.updateLikes(for: postid)
            } catch {
                print(error)
                await MainActor.run {
                    isLiked.toggle() // revert on failure
                }
            }
        }
    }
    
    func loadMorePosts() {
        guard !isLoadingMore && !allPostsLoaded else { return }
        
        isLoadingMore = true
        
        Task {
            do {
                let newPosts = try await postController.getPosts(pageNumber: currentPage + 1)
                await MainActor.run {
                    if newPosts.isEmpty {
                        allPostsLoaded = true
                    } else {
                        posts += newPosts
                        currentPage += 1
                    }
                    isLoadingMore = false
                }
            } catch {
                print("Failed to load more posts:", error)
                isLoadingMore = false
            }
        }
    }
}
