import SwiftUI

struct PostPage: View {
    let postController = PostController()
    @State var posts = [Post]()
    @State private var currentPage = 0
    @State private var isLoadingMore: Bool = false
    @State private var allPostsLoaded: Bool = false
    @State var isShowingEditPost: Bool = false
    @State var selectedPost: Post?

    var body: some View {
        NavigationStack {
            List {
                ForEach(posts, id: \.postid) { post in
                    PostView(post: post)
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
            .sheet(isPresented: $isShowingEditPost, onDismiss: {
                fetchPosts()
            }, content: {
                if let postToEdit = selectedPost {
                    EditPost(post: postToEdit, postController: postController)
                }
            })
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

    

    func fetchPosts() {
        Task {
            do {
                self.posts = try await postController.getPosts()
            } catch {
                print(error)
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
