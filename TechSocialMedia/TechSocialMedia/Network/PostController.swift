//
//  PostController.swift
//  TechSocialMedia
//
//  Created by Hayden Boss on 6/24/25.
//

import Foundation

struct PostController {
    enum PostError: Error, LocalizedError {
        case noUserFound
        case unknownError
    }
    
    
    func createPost(title: String, body: String) async throws -> Post {
        // Initialize our session and request
        let session = URLSession.shared
        var request = URLRequest(url: URL(string: "\(API.url)/createPost")!)
        
        // Put the credentials in JSON format
        /*
         userSecret - UUID
         post: {
         "title": String,
         "body": String
         }
         */
        guard let user = User.current else { throw PostError.noUserFound }
        let credentials: [String: Any] = ["userSecret": user.secret, "post": ["title": title, "body": body]]
        
        // Add json data to the body of the request. Also clarify that this is a POST request
        request.httpBody = try JSONSerialization.data(withJSONObject: credentials, options: .prettyPrinted)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Make the request
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw PostError.unknownError
        }
        
        // Ensure we had a good response (status 200)
        if httpResponse.statusCode == 200 {
            // yay!
        } else if httpResponse.statusCode == 400 {
            throw PostError.noUserFound
        } else {
            throw PostError.unknownError
        }
        
        let decoder = JSONDecoder()
        return try decoder.decode(Post.self, from: data)
    }
//    
//    func editPost(updatedPost: Post) async throws -> Post {
//        let session = URLSession.shared
//        var request = URLRequest(url: URL(string: "\(API.url)/editPost")!)
//        
//        // Put the credentials in JSON format into the request's body
//        /*
//         userSecret: UUID
//         post: {
//             "postid": Int,
//             "title": String,
//             "body": String
//         }
//         */
//        guard let user = User.current else { throw PostError.noUserFound }
//        let credentials: [String: Any] = [
//            "userSecret": user.secret,
//            "post": [
//                "postid": updatedPost.postID,
//                "title": updatedPost.title,
//                "body": updatedPost.body
//            ]
//        ]
//        
//        // Add json data to the body of the request. Also clarify that this is a POST request
//        request.httpBody = try JSONSerialization.data(withJSONObject: credentials, options: .prettyPrinted)
//
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        // Make the request
//        let (data, response) = try await session.data(for: request)
//        
//        // Ensure we had a good response (status 200)
//        guard let httpResponse = response as? HTTPURLResponse else {
//            throw PostError.unknownError
//        }
//        // Ensure we had a good response (status 200)
//        if httpResponse.statusCode == 200 {
//            // yay!
//        } else if httpResponse.statusCode == 400 {
//            throw PostError.noUserFound
//        } else {
//            throw PostError.unknownError
//        }
//        
//        // Decode our response data to a usable User struct
//        let decoder = JSONDecoder()
//       
//    }
    
    func getPosts(pageNumber: Int = 0) async throws -> [Post] {
        let session = URLSession.shared
        var request = URLRequest(url: URL(string: "\(API.url)/posts")!)
        guard let currentUser = User.current else {
            throw PostError.noUserFound
        }
        // Put the credentials in JSON format
        let userParam = URLQueryItem(name: "pageNumber", value: "\(pageNumber)")
        let secretParam = URLQueryItem(name: "userSecret", value: currentUser.secret.uuidString)
        request.url?.append(queryItems: [secretParam, userParam])
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Make the request
        let (data, response) = try await session.data(for: request)
        
        // Ensure we had a good response (status 200)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw PostError.unknownError
        }
        // Ensure we had a good response (status 200)
        if httpResponse.statusCode == 200 {
            // yay!
        } else if httpResponse.statusCode == 400 {
            throw PostError.noUserFound
        } else {
            throw PostError.unknownError
        }
        
        // Decode our response data to a usable User struct
        let decoder = JSONDecoder()
        let posts = try decoder.decode([Post].self, from: data)

        return posts
    }
    
//    func getComments() async throws -> Int {
//        let session = URLSession.shared
//        var request = URLRequest(url: URL(string: "\(API.url)/comments")!)
//        guard let currentUser = User.current else {
//            throw PostError.noUserFound
//        }
//        // Put the credentials in JSON format
//        let pageNumberParam = URLQueryItem(name: "pageNumber", value: "0")
//        let postIDParam = URLQueryItem(name: "postid", value: currentUser.userUUID.uuidString)
//        let secretParam = URLQueryItem(name: "userSecret", value: currentUser.secret.uuidString)
//        request.url?.append(queryItems: [pageNumberParam, postIDParam, secretParam])
//        request.httpMethod = "GET"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        // Make the request
//        let (data, response) = try await session.data(for: request)
//        
//        // Ensure we had a good response (status 200)
//        guard let httpResponse = response as? HTTPURLResponse else {
//            throw PostError.unknownError
//        }
//        // Ensure we had a good response (status 200)
//        if httpResponse.statusCode == 200 {
//            // yay!
//        } else if httpResponse.statusCode == 400 {
//            throw PostError.noUserFound
//        } else {
//            throw PostError.unknownError
//        }
//        
//        // Decode our response data to a usable User struct
//        let decoder = JSONDecoder()
//        let profile = try decoder.decode(UserProfile.self, from: data)
//        
//        return profile
//    }
//    
//    func createComment() async throws -> Post.comments {
//        let session = URLSession.shared
//        var request = URLRequest(url: URL(string: "\(API.url)/createComment")!)
//        guard let currentUser = User.current else {
//            throw PostError.noUserFound
//        }
//        // Put the credentials in JSON format
//        let postIDParam = URLQueryItem(name: "postID", value: "1")
//        let commentParam = URLQueryItem(name: "commentBody", value: currentUser.userUUID.uuidString)
//        let secretParam = URLQueryItem(name: "userSecret", value: currentUser.secret.uuidString)
//        request.url?.append(queryItems: [postIDParam, commentParam, secretParam])
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        // Make the request
//        let (data, response) = try await session.data(for: request)
//        
//        // Ensure we had a good response (status 200)
//        guard let httpResponse = response as? HTTPURLResponse else {
//            throw PostError.unknownError
//        }
//        // Ensure we had a good response (status 200)
//        if httpResponse.statusCode == 200 {
//            // yay!
//        } else if httpResponse.statusCode == 400 {
//            throw PostError.noUserFound
//        } else {
//            throw PostError.unknownError
//        }
//        
//        // Decode our response data to a usable User struct
//        let decoder = JSONDecoder()
//        
//        return
//    }
//    
    func updateLikes(for postid: Int) async throws -> Post {
            // Initialize our session and request
            let session = URLSession.shared
            var request = URLRequest(url: URL(string: "\(API.url)/updateLikes")!)
    
            // Put the credentials in JSON format
            /*
             userSecret - UUID
             postid - Int
             */
            guard let user = User.current else { throw PostError.noUserFound }
        let credentials: [String: Any] = ["userSecret": user.secret.uuidString, "postid": postid]
    
            // Add json data to the body of the request. Also clarify that this is a POST request
            request.httpBody = try JSONSerialization.data(withJSONObject: credentials, options: .prettyPrinted)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
            // Make the request
            let (data, response) = try await session.data(for: request)
    
            guard let httpResponse = response as? HTTPURLResponse else {
                throw PostError.unknownError
            }
    
            // Ensure we had a good response (status 200)
            if httpResponse.statusCode == 200 {
                // yay!
            } else if httpResponse.statusCode == 400 {
                throw PostError.noUserFound
            } else {
                throw PostError.unknownError
            }
        
        let decoder = JSONDecoder()
        let updatedPost = try decoder.decode(Post.self, from: data)
        return updatedPost
        }
//
//    func getUserPosts() async throws -> UserProfile {
//        let session = URLSession.shared
//        var request = URLRequest(url: URL(string: "\(API.url)/userPosts")!)
//        guard let currentUser = User.current else {
//            throw PostError.noUserFound
//        }
//        // Put the credentials in JSON format
//        let userParam = URLQueryItem(name: "userUUID", value: currentUser.userUUID.uuidString)
//        let secretParam = URLQueryItem(name: "userSecret", value: currentUser.secret.uuidString)
//        let pageNumberParam = URLQueryItem(name: "pageNumber", value: "0")
//        request.url?.append(queryItems: [userParam, secretParam, pageNumberParam])
//        request.httpMethod = "GET"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        // Make the request
//        let (data, response) = try await session.data(for: request)
//        
//        // Ensure we had a good response (status 200)
//        guard let httpResponse = response as? HTTPURLResponse else {
//            throw PostError.unknownError
//        }
//        // Ensure we had a good response (status 200)
//        if httpResponse.statusCode == 200 {
//            // yay!
//        } else if httpResponse.statusCode == 400 {
//            throw PostError.noUserFound
//        } else {
//            throw PostError.unknownError
//        }
//        
//        // Decode our response data to a usable User struct
//        let decoder = JSONDecoder()
//       
//    }
//    
//    func deletePost() async throws -> UserProfile {
//        let session = URLSession.shared
//        var request = URLRequest(url: URL(string: "\(API.url)/post")!)
//        guard let currentUser = User.current else {
//            throw PostError.noUserFound
//        }
//        // Put the credentials in JSON format
//        let postIDParam = URLQueryItem(name: "postid", value: post.postID)
//        let secretParam = URLQueryItem(name: "userSecret", value: currentUser.secret.uuidString)
//        request.url?.append(queryItems: [postIDParam, secretParam])
//        request.httpMethod = "DELETE"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        // Make the request
//        let (data, response) = try await session.data(for: request)
//        
//        // Ensure we had a good response (status 200)
//        guard let httpResponse = response as? HTTPURLResponse else {
//            throw PostError.unknownError
//        }
//        // Ensure we had a good response (status 200)
//        if httpResponse.statusCode == 200 {
//            // yay!
//        } else if httpResponse.statusCode == 400 {
//            throw PostError.noUserFound
//        } else {
//            throw PostError.unknownError
//        }
//        
//        // Decode our response data to a usable User struct
//        let decoder = JSONDecoder()
//    }
}
