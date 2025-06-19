//
//  CustomButtonStyle.swift
//  Advanced Techniques Lab
//
//  Created by Hayden Boss on 6/4/25.
//

import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 370, height: 50, alignment: .center)
            .background(Color.blue)
            .cornerRadius(10)
            .foregroundColor(.white)
            .shadow(color: .green, radius: configuration.isPressed ? 10 : 0)
            .foregroundStyle(.white)
    }
}
