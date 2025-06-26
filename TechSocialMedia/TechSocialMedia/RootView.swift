//
//  RootView.swift
//  TechSocialMedia
//
//  Created by Hayden Boss on 6/19/25.
//

import SwiftUI

struct RootView: View {
    @State var loggedInUser: User?
    
    var body: some View {
        if let user = loggedInUser {
            NavigationStack {
                MainView(api: API(user: user))
            }
        } else {
            LogInView(loggedInUser: $loggedInUser)
        }
    }
}

