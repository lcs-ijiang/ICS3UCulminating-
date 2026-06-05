//
//  PersonalInformationView.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 1/6/2026.
//

import SwiftUI

struct PersonalInformationView: View {
    
    // MARK: - Stored properties
    var authManager = AuthManager.shared
    
    // MARK: - Computed properties
    var body: some View {
        List {
            if let user = authManager.currentUser {
                Section {
                    VStack(alignment: .center) {
                        Circle()
                            .fill(Color.blue.opacity(0.1))
                            .frame(width: 80, height: 80)
                            .overlay(
                                Text(user.name.prefix(1))
                                    .font(.system(size: 40, weight: .bold))
                                    .foregroundColor(.blue)
                            )
                        
                        Text(user.name)
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("Email: \(user.email ?? "Not provided")")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                }
                
                Section("Contact Details") {
                    LabeledContent("Phone", value: user.phone_number ?? "Not provided")
                }
                
                Section {
                    NavigationLink {
                        EditProfileView(user: user)
                    } label: {
                        Text("Edit Profile Information")
                            .foregroundColor(.blue)
                    }
                }
            } else {
                Text("Not logged in")
            }
        }
        .navigationTitle("Personal Info")
    }
}

#Preview {
    NavigationStack {
        PersonalInformationView()
    }
}
