//
//  LogInView.swift
//  TechSocialMedia
//
//  Created by Hayden Boss on 6/19/25.
//

import SwiftUI

struct LogInView: View {
    @Binding var loggedInUser: User?
    @State var email = ""
    @State var password = ""
    @State var errorMessage = ""
    @State var isLoading = false
    
    var authenticationController = AuthenticationController()
    
    var body: some View {
        VStack {
            Text("Tech Social Media App")
                .font(.title)
            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
                .padding(.bottom, 24)
            if isLoading {
                ProgressView()
            } else {
                Text(errorMessage)
                    .foregroundStyle(.red)
            }
            Button("Sign in") {
                signInButtonTapped()
            }
            .disabled(email.isEmpty || password.isEmpty || isLoading)
            .padding(.top, 60)
        }
        .onChange(of: email + password, { _, _ in
            errorMessage = ""
        })
        .padding(28)
        .onAppear {
#if DEBUG
//        Uncomment the three lines below and enter your credentials to
//        automatically sign in everytime you launch the app.

        email = "hayden_boss@yahoo.com"
        password = ""
        signInButtonTapped()
#endif
        }
    }
    
    func signInButtonTapped() {
        guard !email.isEmpty, !password.isEmpty else {return}
        errorMessage = ""
        isLoading = true
        Task {
            defer {
                isLoading = false
            }
            do {
                loggedInUser = try await authenticationController.signIn(email: email, password: password)
            } catch {
                print(error)
                errorMessage = "Invalid Username or Password"
            }
        }
    }
}

#Preview {
    LogInView(loggedInUser: .constant(nil))
}
