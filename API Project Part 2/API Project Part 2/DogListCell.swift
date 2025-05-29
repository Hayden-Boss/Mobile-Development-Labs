//
//  DogListCell.swift
//  API Project Part 2
//
//  Created by Hayden Boss on 5/28/25.
//

import SwiftUI

struct DogListCell: View {
    let dog: Dog

    var body: some View {
        HStack {
            AsyncImage(url: dog.imageURL) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                } else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 60, height: 60)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }

            Text(dog.name)
                .font(.headline)
                .padding(.leading, 10)

            Spacer()
        }
        .padding(.vertical, 4)
    }
    
}
