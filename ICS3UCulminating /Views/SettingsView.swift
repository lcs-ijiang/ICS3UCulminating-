//
//  SettingsView.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 1/6/2026.
//

import SwiftUI

struct SettingsView: View {
    
    // MARK: - Stored properties
    @State var viewModel = SettingsViewModel()
    @Environment(\.dismiss) var dismiss
    
    // MARK: - Computed properties
    var body: some View {
        Form {
            Section("Account") {
                NavigationLink {
                    PersonalInformationView()
                } label: {
                    Label("Personal Information", systemImage: "person.circle")
                }
                
                NavigationLink {
                    AppPreferenceView()
                } label: {
                    Label("App Preferences", systemImage: "sliders.horizontal.3")
                }
            }
            
            Section("Notifications") {
                Toggle("Push Notifications", isOn: $viewModel.pushNotificationsEnabled)
                Toggle("Dark Mode", isOn: $viewModel.darkModeEnabled)
            }
            
            Section {
                Button(role: .destructive) {
                    viewModel.logout()
                    dismiss()
                } label: {
                    HStack {
                        Spacer()
                        Text("Log Out")
                        Spacer()
                    }
                }
            }
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
}
