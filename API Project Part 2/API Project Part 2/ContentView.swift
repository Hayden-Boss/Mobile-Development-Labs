//
//  ContentView.swift
//  API Project Part 2
//
//  Created by Hayden Boss on 5/27/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = DogViewModel()
    @State private var showImage = false

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                ZStack {
                    if let dog = viewModel.currentDog {
                        DogImageView(url: dog.imageURL)
                            .id(dog.id) // <-- Important!
                            .transition(.move(edge: .top).combined(with: .opacity))
                    }
                }
                .animation(.easeOut(duration: 0.5), value: viewModel.currentDog?.id)
                .frame(height: 300)
                .frame(height: 300)

                TextField("Enter dog name", text: $viewModel.dogName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                Button("New Image") {
                    showImage = false // Hide current image
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        viewModel.fetchNewDog()
                        withAnimation(.easeOut(duration: 0.5)) {
                            showImage = true
                        }
                    }
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)

                List {
                    ForEach($viewModel.savedDogs) { $dog in
                        NavigationLink(destination: DogDetailView(dog: $dog)) {
                            DogListCell(dog: dog)
                        }
                    }
                }
            }
            .navigationTitle("Dog Viewer")
        }
    }
}

struct DogImageView: View {
    let url: URL

    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                Color.clear
                    .frame(width: 300, height: 300)
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .cornerRadius(10)
            case .failure:
                Image(systemName: "xmark.octagon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .foregroundColor(.red)
            @unknown default:
                EmptyView()
            }
        }
    }
}

#Preview {
    ContentView()
}
