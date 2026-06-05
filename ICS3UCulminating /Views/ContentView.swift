//
//  ContentView.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 1/6/2026.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Stored properties
    // Watching the shared AuthManager for login changes
    var authManager = AuthManager.shared
    
    // MARK: - Computed properties
    var body: some View {
        Group {
            // ROUTING LOGIC:
            // If logged out, show Login screen. If logged in, show Dashboard.
            switch authManager.authState {
            case .loggedOut:
                LoginView()
            case .loggedIn:
                DiscoverDashboardView()
            }
        }
    }
}

#Preview {
    ContentView()
}
