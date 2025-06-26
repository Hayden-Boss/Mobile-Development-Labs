//
//  ProfileController.swift
//  TechSocialMedia
//
//  Created by Hayden Boss on 6/23/25.
//

import Foundation

class ProfileController {
    
    enum UserError: Error, LocalizedError {
        case currentUserNotFound
        case serverError
    }
    
    func getProfile() async throws -> UserProfile {
        let session = URLSession.shared
        var request = URLRequest(url: URL(string: "\(API.url)/userProfile")!)
        guard let currentUser = User.current else {
            throw UserError.currentUserNotFound
        }
        // Put the credentials in JSON format
        let userParam = URLQueryItem(name: "userUUID", value: currentUser.userUUID.uuidString)
        let secretParam = URLQueryItem(name: "userSecret", value: currentUser.secret.uuidString)
        request.url?.append(queryItems: [userParam, secretParam])
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Make the request
        let (data, response) = try await session.data(for: request)
        
        // Ensure we had a good response (status 200)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw UserError.serverError
        }
        // Ensure we had a good response (status 200)
        if httpResponse.statusCode == 200 {
            // yay!
        } else if httpResponse.statusCode == 400 {
            throw UserError.currentUserNotFound
        } else {
            throw UserError.serverError
        }
        
        // Decode our response data to a usable User struct
        let decoder = JSONDecoder()
        let profile = try decoder.decode(UserProfile.self, from: data)
        
        return profile
    }
    
//    func updateProfile() async throws -> UserProfile {
//        let session = URLSession.shared
//        var request = URLRequest(url: URL(string: "\(API.url)/updateProfile")!)
//        guard let currentUser = User.current else {
//            throw UserError.currentUserNotFound
//        }
//        // Put the credentials in JSON format
//        guard let user = User.current else { throw UserError.currentUserNotFound }
//        let profileParam: [String: Any] = ["userSecret": user.secret, "profile": ["userName": User.init().userName ?? "", "bio": UserProfile.current?.bio ?? "", "TechInterests": UserProfile.init().techInterests]]
//        request.url?.append(queryItems: [userParam, secretParam])
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        // Make the request
//        let (data, response) = try await session.data(for: request)
//        
//        guard let httpResponse = response as? HTTPURLResponse else {
//            throw UserError.serverError
//        }
//        // Ensure we had a good response (status 200)
//        if httpResponse.statusCode == 200 {
//            // yay!
//        } else if httpResponse.statusCode == 400 {
//            throw UserError.currentUserNotFound
//        } else {
//            throw UserError.serverError
//        }
//        
//        // Decode our response data to a usable User struct
//        let decoder = JSONDecoder()
//        let profile = try decoder.decode(UserProfile.self, from: data)
//        
//        return profile
//    }
    
}

