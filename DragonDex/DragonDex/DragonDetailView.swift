//
//  DragonDetailView.swift
//  DragonDex
//
//  Created by Hayden Boss on 5/16/25.
//

import SwiftUI

struct DragonDetailView: View {
    let dragon: Dragon
    
    var body: some View {
        VStack(spacing: 20) {
            Image(dragon.thumbnail)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
            
            Text(dragon.name).font(.headline)
            Text(dragon.lore).font(.subheadline)
            
            NavigationLink("View Powers") {
                PowersListView(powers: dragon.powers)
            }
            .padding()
        }
        .padding()
        .navigationBarTitle(dragon.name)
    }
}
