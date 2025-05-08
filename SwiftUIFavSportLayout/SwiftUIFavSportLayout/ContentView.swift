//
//  ContentView.swift
//  SwiftUIFavSportLayout
//
//  Created by Hayden Boss on 5/1/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedSport: Sport? = nil
    @State private var hasSubmitted = false
    
    let sports: [Sport] = Sport.dummySports
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea(edges: .all)
            
            VStack {
                Spacer()
                
                Text("Favorite Sport")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                
                Spacer()
                
                VStack(spacing: 20) {
                    ForEach(sports) { sport in
                        SportButtonView(sport: sport, selectedSport: $selectedSport)
                    }
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
                        Text("You chose \(sport.name)")
                            .foregroundStyle(.white)
                            .padding(.top)
                    }
                }
                
                Spacer()
            }
        }
    }
    
    func handleSportTap(_ sport: Sport) {
        selectedSport = sport
        if hasSubmitted {
            hasSubmitted = false
        }
    }
}




#Preview {
    ContentView()
    
}
