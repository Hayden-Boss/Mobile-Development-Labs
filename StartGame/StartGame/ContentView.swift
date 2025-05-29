//
//  ContentView.swift
//  StartGame
//
//  Created by Hayden Boss on 5/15/25.
//

import SwiftUI

struct ContentView: View {
    @State private var countText: String = "3"
    @State private var showText: Bool = false
    @State private var scale: CGFloat = 1.5
    @State private var gameStarted: Bool = false

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack {
                Spacer()

                Text(countText)
                    .font(.system(size: countText == "Go!" ? 100 : 200))
                    .foregroundColor(.white)
                    .opacity(showText ? 1 : 0)
                    .scaleEffect(scale)

                Spacer()

                Button("Start Game") {
                    if !gameStarted {
                        startCountdown()
                    }
                }
                .font(.title2)
                .padding(.bottom, 40)
            }
        }
    }

    func startCountdown() {
        gameStarted = true
        let countdown = ["3", "2", "1", "Go!"]

        for (index, value) in countdown.enumerated() {
            let delay = Double(index) * 1.2

            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                countText = value
                scale = 2.0
                showText = false

                // Animate fade in and shrink
                withAnimation(.easeOut(duration: 0.5)) {
                    scale = 0.5
                    showText = true
                }

                // Fade out for numbers, but not "Go!"
                if value != "Go!" {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                        withAnimation(.easeInOut(duration: 0.4)) {
                            showText = false
                        }
                    }
                }
            }
        }
    }
}


#Preview {
    ContentView()
}
