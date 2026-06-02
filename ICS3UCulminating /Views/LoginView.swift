//
//  LoginView.swift
//  Piper app exercise
//
//  Created by Student on 2/3/2026.
//

import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = "" // Assuming the second field is for password

    var body: some View {
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
                    
                    Text("Sign in to access your dashboard and meet someone who understand you better")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }

                VStack(alignment: .leading, spacing: 12) {
                    Text("Username")
                        .font(.subheadline)
                        .fontWeight(.medium)
                    
                    // Email/Username Field
                    CustomTextField(placeholder: "jiangyishan@gmail.com", text: $username)
                    Text("Password")
                        .font(.subheadline)
                        .fontWeight(.medium)                    // Password Field (Duplicated appearance from your screenshot)
                    CustomTextField(placeholder: "jiangyishan@gmail.com", text: $password, isSecure: true)
                }
                .padding(.top, 10)

                // 3. Sign In Button
                Button(action: {
                    // Sign in logic
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

                // 4. Social Sign Up Section
                VStack(spacing: 20) {
                    Text("Or Sign Up Using")
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    HStack(spacing: 15) {
                        SocialButton(label: "A")
                        SocialButton(label: "T")
                        SocialButton(label: "G")
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
    }
}

// Reusable custom Text Field component
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

// Reusable Social Login Circle
struct SocialButton: View {
    var label: String
    
    var body: some View {
        Text(label)
            .font(.headline)
            .foregroundColor(.white)
            .frame(width: 50, height: 50)
            .background(Color(red: 88/255, green: 101/255, blue: 180/255)) // Muted blue/purple
            .clipShape(Circle())
    }
}

#Preview {
    LoginView()
}

