//
//  SportButtonView.swift
//  SwiftUIFavSportLayout
//
//  Created by Hayden Boss on 5/6/25.
//

import SwiftUI

struct SportButtonView: View {
    let sport: Sport
    @Binding var selectedSport: Sport?

    var body: some View {
        Button {
            selectedSport = sport
        } label: {
            Text(sport.name)
                .frame(width: 100, height: 80)
        }
        .buttonStyle(.borderedProminent)
        .tint(.green)
        .opacity(selectedSport == sport ? 1.0 : 0.4)
    }
}

#Preview {
}
