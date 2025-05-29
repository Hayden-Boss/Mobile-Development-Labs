//
//  ContentView.swift
//  DragonDex
//
//  Created by Hayden Boss on 5/16/25.
//

import SwiftUI

struct ContentView: View {
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Text("Welcome to DragonDex!")
                    .font(.largeTitle)

                Button("Go to Dragon List") {
                    path.append("dragonList")
                }
            }
            .navigationDestination(for: String.self) { value in
                if value == "dragonList" {
                    DragonListView()
                }
            }
            .navigationDestination(for: Dragon.self) { dragon in
                DragonDetailView(dragon: dragon)
            }
        }
    }
}

#Preview {
    ContentView()
}
