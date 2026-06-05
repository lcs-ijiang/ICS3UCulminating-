//
//  PersonalInformationView.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 1/6/2026.
//

import SwiftUI

struct PersonalInformationView: View {
    
    // MARK: - Stored properties
    var user = AuthManager.shared.currentUser
    
    // MARK: - Computed properties
    var body: some View {
        List {
            if let user = user {
                Section("User Profile") {
                    HStack {
                        Text("Full Name")
                        Spacer()
                        Text(user.full_name)
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("Phone")
                        Spacer()
                        Text(user.phone_number)
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("Student ID")
                        Spacer()
                        Text(user.student_id)
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("Profile ID")
                        Spacer()
                        Text(user.id.uuidString.prefix(8))
                            .foregroundColor(.secondary)
                    }
                }
                
                Section("Interests") {
                    ForEach(user.interests, id: \.self) { interest in
                        Text(interest)
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
