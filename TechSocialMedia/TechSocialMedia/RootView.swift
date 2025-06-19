//
//  RootView.swift
//  TechSocialMedia
//
//  Created by Hayden Boss on 6/19/25.
//

import SwiftUI

struct RootView: View {
    @State var isLoggedIn: Bool = false
    
    var body: some View {
        if isLoggedIn {
            Text("Logged in")
        } else {
            LogInView(isLoggedIn: $isLoggedIn)
        }
    }
}
