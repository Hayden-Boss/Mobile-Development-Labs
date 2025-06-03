//
//  ContentView.swift
//  Lazy Grids Lab
//
//  Created by Hayden Boss on 6/2/25.
//


extension Color {
    static func random() -> Color {
        return Color(
            red: Double.random(in: 0.5...1),
            green: Double.random(in: 0.5...1),
            blue: Double.random(in: 0.5...1)
        )
    }
}
    
import SwiftUI

struct ClothingView: View {
    let item: Clothing
    let size: CGFloat
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(item.name)
                .font(.caption)
                .fontWeight(.bold)
            Text("$\(item.price, specifier: "%.2f")")
                .font(.caption2)
            Text(item.color)
                .font(.caption2)
        }
        .padding()
        .frame(width: size, height: size)
        .background(Color.random())
        .cornerRadius(10)
    }
}

struct ContentView: View {
    @StateObject private var viewModel = ClothingViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading, spacing: 32) {
                    Text("Hats")
                        .font(.title2)
                        .frame(maxWidth: .infinity, alignment: .center)

                    ScrollView(.horizontal) {
                        LazyHGrid(rows: [GridItem(.flexible())]) {
                            ForEach(viewModel.hats) { hat in
                                ClothingView(item: hat, size: 130)
                            }
                        }
                        .scrollTargetLayout()
                        .padding(.horizontal)
                    }
                    .scrollTargetBehavior(.viewAligned)
                    
                    Text("Shirts")
                        .font(.title2)
                        .frame(maxWidth: .infinity, alignment: .center)

                    ScrollView(.horizontal) {
                        LazyHGrid(rows: [GridItem(.fixed(110)), GridItem(.fixed(110))]) {
                            ForEach(viewModel.shirts) { shirt in
                                ClothingView(item: shirt, size: 115)
                            }
                        }
                        .scrollTargetLayout()
                        .padding(.horizontal)
                    }
                    .scrollTargetBehavior(.viewAligned)
                    
                    Text("Pants")
                        .font(.title2)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: Array(repeating: GridItem(.adaptive(minimum: 50)), count: 4)) {
                            ForEach(viewModel.pants) { pant in
                                ClothingView(item: pant, size: 97)
                            }
                        }
                        .scrollTargetLayout()
                        .padding(.horizontal)
                    }
                    .scrollTargetBehavior(.paging)
                }
                .padding(.top)
            }
        }
    }
}

#Preview {
    ContentView()
}
