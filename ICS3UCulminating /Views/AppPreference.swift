//
//  AppPreference.swift
//  ICS3UCulminating
//
//  Created by Student on 2/3/2026.
//

import SwiftUI

struct AppPreferenceView: View {
    
    // MARK: - Stored properties
    @State private var selectedLanguage = "English"
    @State private var matchRequests = true
    @State private var newPosts = true
    @State private var messages = true

    // MARK: - Computed properties
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            
            // 1. Language Selection Section
            VStack(alignment: .leading, spacing: 20) {
                Text("Language")
                    .font(.title2)
                    .fontWeight(.bold)

                HStack(spacing: 20) {
                    LanguageButton(title: "English", isSelected: selectedLanguage == "English") {
                        selectedLanguage = "English"
                    }
                    
                    LanguageButton(title: "Chinese", isSelected: selectedLanguage == "Chinese") {
                        selectedLanguage = "Chinese"
                    }
                }
            }

            // 2. Notification Settings Section
            VStack(alignment: .leading, spacing: 25) {
                Text("Notification")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)

                Toggle("Match Requests", isOn: $matchRequests)
                    .font(.headline)
                
                Toggle("New posts", isOn: $newPosts)
                    .font(.headline)
                
                Toggle("Messages", isOn: $messages)
                    .font(.headline)
            }
            .tint(.blue)

            Spacer()
        }
        .padding(30)
        .navigationTitle("App Preferences")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.white)
    }
}

// MARK: - Reusable Language Button Component
struct LanguageButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .fontWeight(.medium)
                .foregroundColor(.black)
                .frame(width: 130, height: 100)
                .background(isSelected ? Color(red: 0.4, green: 0.5, blue: 1.0) : Color(white: 0.85))
                .border(Color.black, width: 1)
        }
    }
}

#Preview {
    NavigationStack {
        AppPreferenceView()
    }
}
