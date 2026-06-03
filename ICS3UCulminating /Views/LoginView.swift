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
        Group {
            if viewModel.isAuthenticated {
                DiscoverDashboardView()
            } else {
                VStack(spacing: 40) {
                    // 1. App Title
                    Text("CampusConnect")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(Color(red: 26/255, green: 35/255, blue: 126/255)) // Deep blue
                        .padding(.top, 60)

                    // 2. Main Login Card
                    VStack(alignment: .leading, spacing: 20) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Welcome Back!")
                                .font(.headline)
                                .fontWeight(.bold)
                            
                            Text("Sign in to access your dashboard and meet someone who understands you better.")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }

                        VStack(alignment: .leading, spacing: 12) {
                            Text("Username")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            // Username Field
                            CustomTextField(placeholder: "e.g. student", text: $viewModel.username)
                            
                            Text("Password")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            // Password Field
                            CustomTextField(placeholder: "••••••••", text: $viewModel.password, isSecure: true)
                        }
                        .padding(.top, 10)

                        // 3. Sign In Button
                        Button(action: {
                            viewModel.signIn()
                        }) {
                            Text("Sign In")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue.opacity(0.8))
                                .cornerRadius(30)
                        }
                        .padding(.top, 20)

                        // 4. Create Account Section
                        VStack(spacing: 20) {
                            Text("Don't have an account?")
                                .font(.subheadline)
                                .foregroundColor(.gray)

                            Button(action: {
                                viewModel.createAccount()
                            }) {
                                Text("Create Account")
                                    .font(.headline)
                                    .foregroundColor(.blue)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.top, 10)
                    }
                    .padding(30)
                    .background(Color(white: 0.98)) // Very light gray card background
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
}

// MARK: - Reusable custom Text Field component
struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String
    var isSecure: Bool = false

    var body: some View {
        Group {
            if isSecure {
                SecureField(placeholder, text: $text)
            } else {
                TextField(placeholder, text: $text)
            }
        }
        .padding()
        .background(Color(white: 0.92))
        .cornerRadius(25)
    }
}

#Preview {
    LoginView()
}
