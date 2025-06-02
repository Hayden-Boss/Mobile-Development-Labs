//
//  ProfileCard.swift
//  GeometryReader Lab
//
//  Created by Hayden Boss on 5/30/25.
//

import SwiftUI

struct ProfileCard: View {
    let profile: Profile
    let width: CGFloat

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: profile.image)
                .resizable()
                .scaledToFit()
                .frame(height: 60)
                .foregroundColor(.blue)

            Text(profile.name)
                .font(.headline)

            Text(profile.description)
                .font(.caption)
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
        }
        .padding()
        .frame(width: width)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}
