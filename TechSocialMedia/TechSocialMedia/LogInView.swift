//
//  LogInView.swift
//  TechSocialMedia
//
//  Created by Hayden Boss on 6/19/25.
//

import SwiftUI

struct LogInView: View {
    @Binding var isLoggedIn: Bool
    @State var email = ""
    @State var password = ""
    @State var errorMessage = ""
    var authenticationController = AuthenticationController()
    
    var body: some View {
        VStack {
            Text("Tech Social Media App")
                .font(.title)
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 24)
            Text(errorMessage)
                .foregroundStyle(Color.red)
            
            Button("Sign in") {
                signInButtonTapped()
            }
            .disabled(email.isEmpty || password.isEmpty)
            .padding(.top, 80)
        }
        .padding(28)
        .onAppear {
#if DEBUG
//        Uncomment the three lines below and enter your credentials to
//        automatically sign in everytime you launch the app.

        email = "hayden_boss@yahoo.com"
        password = "Password123"
        signInButtonTapped()
#endif
        }
    }
    
    func signInButtonTapped() {
        guard !email.isEmpty, !password.isEmpty else {return}
        
        Task {
            do {
                isLoggedIn = try await authenticationController.signIn(email: email, password: password)
            } catch {
                print(error)
                errorMessage = "Invalid Username or Password"
            }
        }
    }
}

#Preview {
    LogInView(isLoggedIn: .constant(false))
}
