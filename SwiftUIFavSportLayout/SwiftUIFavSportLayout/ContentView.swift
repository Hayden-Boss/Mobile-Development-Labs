//
//  ContentView.swift
//  SwiftUIFavSportLayout
//
//  Created by Hayden Boss on 5/1/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea(edges: .all)
            VStack {
                Spacer()
                Text("Favorite Sport")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                Spacer()
                HStack {
                    fancyButton(title: "Golf")
                    fancyButton(title: "Football")
                }
                HStack {
                    fancyButton(title: "Soccer")
                    fancyButton(title: "Baseball")
                }
                Spacer()
                Button {
                } label: {
                    Text("Submit")
                        .frame(width: 230, height: 25)
                }
                .buttonStyle(.borderedProminent)
                Spacer()
            }
        }
    }
    func fancyButton(title: String) -> some View {
        Button {
        } label: {
            Text(title)
                .frame(width: 70, height: 80)
        }
        .buttonStyle(.borderedProminent)
        .tint(Color.green)
    }
}


#Preview {
    ContentView()
    
}
