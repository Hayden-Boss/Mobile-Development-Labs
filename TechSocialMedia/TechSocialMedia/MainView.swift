//
//  MainView.swift
//  TechSocialMedia
//
//  Created by Hayden Boss on 6/19/25.
//

import SwiftUI

struct MainView: View {
    let api: API
    
    private let profileController = ProfileController()
    
    var body: some View {
        TabView {
            PostPage()
                .tabItem {
                    Label("Posts", systemImage: "line.3.horizontal")
                }
            
            ProfilePage()
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
        }
    }
}
