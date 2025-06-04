//
//  ContentView.swift
//  Advanced Techniques Lab
//
//  Created by Hayden Boss on 6/4/25.
//

import SwiftUI

struct ContentView: View {
    @State private var username: String = ""
    
    var body: some View {
        VStack {
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            Text("Hello, world!")
        }
        .padding()
    }
}


#Preview {
    ContentView()
}
