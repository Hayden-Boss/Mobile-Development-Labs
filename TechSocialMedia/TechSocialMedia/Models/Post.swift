//
//  Post.swift
//  TechSocialMedia
//
//  Created by Hayden Boss on 6/24/25.
//

import SwiftUI

struct Post: Codable {
    var postid: Int // JSON key is "postid"
    var likes: Int
    var numComments: Int // JSON Key is "numComments"
    var title: String
    var body: String
    var createdDate: String // JSON Key is `createdDate`
    var authorUserName: String
    var authorUserId: String
    var userLiked: Bool = false
//    var photo: Photo
}
