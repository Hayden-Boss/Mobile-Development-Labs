//
//  ContentView.swift
//  Advanced Techniques Lab
//
//  Created by Hayden Boss on 6/4/25.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var loginState = LoginState.idle
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                Text("Login")
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                TextField("Username", text: $username)
                    .modifier(TextFieldStyle())
                
                TextField("Password", text: $password)
                    .modifier(TextFieldStyle())

                Button("Login") {
                    if username.isEmpty || password.isEmpty {
                        loginState = .failure
                        return
                    }
                    loginState = .loading
                    Task {
                        await makeNetworkCall()
                        loginState = .success
                    }
                }
                .buttonStyle(CustomButtonStyle())
                Group {
                    switch loginState {
                    case .idle:
                        EmptyView()
                    case .loading:
                        ProgressView()
                            .tint(Color.white)
                    case .success:
                        Text("Successfully logged in")
                            .foregroundStyle(.green)
                    case .failure:
                        Text("Something went wrong")
                            .foregroundStyle(.red)
                    }
                }
                // switch on loadingState
                // Failure == Text(failuremessage)
                // success == text("success")?
                // laoding == progressindicator
                // idle == emptyview
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
    }
    
    func makeNetworkCall() async {
        try? await Task.sleep(for: .seconds(3))
        return
    }
}

#Preview {
    ContentView()
}
