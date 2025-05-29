//
//  DogDetailView.swift
//  API Project Part 2
//
//  Created by Hayden Boss on 5/28/25.
//

import SwiftUI

struct DogDetailView: View {
    @Binding var dog: Dog

    var body: some View {
        VStack(spacing: 20) {
            AsyncImage(url: dog.imageURL) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(height: 300)
                        .cornerRadius(10)
                } else {
                    ProgressView()
                        .frame(height: 300)
                }
            }

            TextField("Dog's name", text: $dog.name)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)

            Spacer()
        }
        .navigationTitle("Dog Detail")
        .padding()
    }
}
