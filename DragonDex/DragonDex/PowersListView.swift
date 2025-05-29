//
//  PowersListView.swift
//  DragonDex
//
//  Created by Hayden Boss on 5/16/25.
//

import SwiftUI

struct PowersListView: View {
    let powers: [String]
    
    var body: some View {
        List(powers, id: \.self) { power in
            Text(power)
        }
        .navigationTitle("Powers")
    }
}
