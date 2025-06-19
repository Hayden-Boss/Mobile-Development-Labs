//
//  TextFieldStyle.swift
//  Advanced Techniques Lab
//
//  Created by Hayden Boss on 6/4/25.
//

import SwiftUI

struct TextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.horizontal)
            .frame(width: 370, height: 50)
            .background(Color(.white))
            .cornerRadius(10)
            .foregroundColor(Color(.black))
            .shadow(color: .white, radius: 4)
    }
}
