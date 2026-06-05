//
//  ContentView.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 1/6/2026.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Stored properties
    // We observe the AuthManager. When 'authState' changes, this view body re-runs automatically.
    var authManager = AuthManager.shared
    
    // MARK: - Computed properties
    var body: some View {
        // This 'Group' acts as our main traffic controller
        Group {
            if authManager.authState == .loggedIn {
                // If logged in, show the main dashboard
                // This replaces the entire screen so the user can't "go back" to login
                DiscoverDashboardView()
            } else {
                // If logged out, show the login flow (which includes signup)
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
}
