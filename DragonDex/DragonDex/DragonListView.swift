//
//  DragonListView.swift
//  DragonDex
//
//  Created by Hayden Boss on 5/16/25.
//

import SwiftUI

struct DragonListView: View {
    var body: some View {
        List(sampleDragons) { dragon in
            NavigationLink(value: dragon) {
                HStack {
                    Image(dragon.thumbnail)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                    Text(dragon.name)
                }
            }
        }
        .navigationTitle("Dragon List")
        .navigationDestination(for: Dragon.self) { dragon in
            DragonDetailView(dragon: dragon)
        }
    }
}
