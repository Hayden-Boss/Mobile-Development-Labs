//
//  UserProfile.swift
//  TechSocialMedia
//
//  Created by Hayden Boss on 6/23/25.
//

import Foundation

struct UserProfile: Codable {
    let bio: String
    let techInterests: String
    let posts: [Post]
    
    static var current: UserProfile?
}
