//
//  LoginView.swift
//  ICS3UCulminating
//
//  Created by Student on 2/3/2026.
//

import SwiftUI

struct LoginView: View {
    
    // MARK: - Stored properties
    @State var viewModel = LoginViewModel()
    
    // MARK: - Computed properties
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                // 1. App Title
                Text("CampusConnect")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(Color(red: 26/255, green: 35/255, blue: 126/255))
                    .padding(.top, 40)

                // 2. Main Login Card
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Welcome Back!")
                            .font(.headline)
                            .fontWeight(.bold)
                        
                        Text("Sign in with your email to access your dashboard.")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Email Address")
                            .font(.subheadline)
                            .fontWeight(.medium)
                        
                        CustomTextField(placeholder: "e.g. yishan@example.com", text: $viewModel.email)
                    }

                    // Sign In Button
                    if viewModel.isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                    } else {
                        Button(action: {
                            Task { await viewModel.signIn() }
                        }) {
                            Text("Sign In with Email")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue.opacity(0.8))
                                .cornerRadius(30)
                        }
                    }
                }
                .padding(30)
                .background(Color(white: 0.98))
                .cornerRadius(40)
                .padding(.horizontal, 20)

                // 3. Google OAuth Pipeline Button
                Button(action: {
                    Task { await viewModel.signInWithGoogle() }
                }) {
                    HStack {
                        Image(systemName: "globe") // Placeholder for Google icon
                        Text("Continue with Google")
                    }
                    .font(.headline)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 30).stroke(Color.gray.opacity(0.3)))
                }
                .padding(.horizontal, 50)

                // 4. Create Account Section
                VStack(spacing: 15) {
                    Text("Don't have an account?")
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    NavigationLink {
                        CreateAccountView()
                    } label: {
                        Text("Create Account")
                            .font(.headline)
                            .foregroundColor(.blue)
                    }
                }
                
                Spacer()
            }
            .edgesIgnoringSafeArea(.bottom)
            .alert("Authentication", isPresented: $viewModel.isShowingError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(viewModel.errorMessage)
            }
        }
    }
}

#Preview {
    LoginView()
}
