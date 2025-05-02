//
//  ContentView.swift
//  SwiftUIFavSportLayout
//
//  Created by Hayden Boss on 5/1/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedSport: String? = nil
    @State private var hasSubmitted = false
    
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
                    hasSubmitted = true
                } label: {
                    Text("Submit")
                        .frame(width: 230, height: 25)
                }
                .buttonStyle(.borderedProminent)
                
                if hasSubmitted {
                    if let sport = selectedSport {
                        Text("You chose \(sport)")
                            .foregroundStyle(.white)
                            .padding(.top)
                    } else {
                    }
                }
                
                Spacer()
            }
        }
    }
    
    func fancyButton(title: String) -> some View {
        Button {
            selectedSport = title
            if hasSubmitted {
                hasSubmitted = false
            }
        } label: {
            Text(title)
                .frame(width: 70, height: 80)
        }
        .buttonStyle(.borderedProminent)
        .tint(.green)
        .opacity(selectedSport == nil ? 1.0 : (selectedSport == title ? 1.0 : 0.4))
    }
}



#Preview {
    ContentView()
    
}
