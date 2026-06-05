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
            VStack(spacing: 40) {
                // 1. App Title
                Text("CampusConnect")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(Color(red: 26/255, green: 35/255, blue: 126/255))
                    .padding(.top, 60)

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
                    .padding(.top, 10)

                    // 3. Sign In Button
                    if viewModel.isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                    } else {
                        Button(action: {
                            Task { await viewModel.signIn() }
                        }) {
                            Text("Sign In")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue.opacity(0.8))
                                .cornerRadius(30)
                        }
                    }
                    
                    // 4. Create Account Section
                    VStack(spacing: 20) {
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
                    .frame(maxWidth: .infinity)
                    .padding(.top, 10)
                }
                .padding(30)
                .background(Color(white: 0.98))
                .cornerRadius(40)
                .padding(.horizontal, 20)

                Spacer()
            }
            .edgesIgnoringSafeArea(.bottom)
            .alert("Login Error", isPresented: $viewModel.isShowingError) {
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
