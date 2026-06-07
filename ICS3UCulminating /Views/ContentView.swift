//
//  ContentView.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 1/6/2026.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Stored properties
    // We observe the AuthManager singleton directly.
    var authManager = AuthManager.shared
    
    // MARK: - Computed properties
    var body: some View {
        // We wrap in a ZStack or Group to ensure SwiftUI tracks the authState property
        ZStack {
            if authManager.authState == .loggedIn {
                // Main Dashboard
                DiscoverDashboardView()
                    .transition(.opacity)
            } else {
                // Login/Signup stack
                LoginView()
                    .transition(.opacity)
            }
            
            // Global loading overlay if AuthManager is working in background
            if authManager.isLoading {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                ProgressView("Synchronizing...")
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
            }
        }
        .animation(.easeInOut, value: authManager.authState)
    }
}

#Preview {
    ContentView()
}
