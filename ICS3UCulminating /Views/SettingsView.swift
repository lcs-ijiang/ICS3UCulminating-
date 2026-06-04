//
//  SettingsView.swift
//  Piper app exercise
//
//  Created by Student on 2/3/2026.
//
import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                // 1. Navigation Header
                HStack {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("Setting")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)

                // 2. Settings Menu Card
                VStack(spacing: 0) {
                    SettingsRow(title: "Edit Profile")
                    SettingsRow(title: "Security")
                    SettingsRow(title: "Preferences")
                    SettingsRow(title: "Privacy", isLast: true)
                }
                .background(Color.white)
                .cornerRadius(12)
                .padding(.horizontal, 20)
                // Optional: add a subtle shadow to match the card look
                .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)

                Spacer()

                // 3. Sign Out Button
                Button(action: {
                    // Sign out logic here
                }) {
                    HStack(spacing: 12) {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .font(.title3)
                        Text("Sign out")
                            .font(.headline)
                    }
                    .foregroundColor(.red)
                    .frame(width: 280, height: 60)
                    .background(Color.white)
                    // Matches the border/shadow style in the image
                    .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                }
                .padding(.bottom, 50)
            }
            .background(Color(white: 0.98)) // Light gray background
        }
    }
}

// Reusable component for each setting item
struct SettingsRow: View {
    let title: String
    var isLast: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(title)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
            }
            .padding(.vertical, 30)
            .padding(.horizontal, 25)
            
            // Thin divider between items, except the last one
            if !isLast {
                Divider()
                    .padding(.horizontal, 20)
            }
        }
    }
}

#Preview {
    SettingsView()
}
