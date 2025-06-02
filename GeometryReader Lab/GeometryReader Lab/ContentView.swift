//
//  ContentView.swift
//  GeometryReader Lab
//
//  Created by Hayden Boss on 5/29/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.horizontalSizeClass) var sizeClass

    var body: some View {
        ScrollView {
            GeometryReader { geometry in
                let columnCount = (sizeClass == .compact) ? 2 : 3
                let itemWidth = geometry.size.width / Double(columnCount) - 16
                let rowCount = (profiles.count + columnCount - 1) / columnCount
                
                VStack(alignment: .center, spacing: 12) {
                    ForEach(0..<rowCount, id: \.self) { row in
                        HStack {
                            ForEach(0..<columnCount, id: \.self) { column in
                                let index = row * columnCount + column
                                if index < profiles.count {
                                    ProfileCard(profile: profiles[index], width: itemWidth)
                                } else {
                                    Spacer().frame(width: itemWidth)
                                }
                            }
                        }
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    ContentView()
}
