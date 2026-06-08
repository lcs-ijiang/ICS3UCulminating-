//
//  ContentView.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 1/6/2026.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Stored properties
    // Using @Bindable or just reading from the shared singleton
    // Since AuthManager is @Observable, any view that reads its properties will refresh automatically.
    var authManager = AuthManager.shared
    
    // MARK: - Computed properties
    var body: some View {
        Group {
            if authManager.authState == .loggedIn {
                // SUCCESS: User is logged in, show the Dashboard
                DiscoverDashboardView()
                    .onAppear { print("🖥️ VIEW: Switched to Dashboard") }
            } else {
                // Default: Show the login flow
                LoginView()
                    .onAppear { print("🖥️ VIEW: Showing Login screen") }
            }
        }
        .animation(.spring(), value: authManager.authState)
        .overlay {
            if authManager.isLoading {
                ZStack {
                    Color.black.opacity(0.2).ignoresSafeArea()
                    ProgressView("Connecting to Campus...")
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
