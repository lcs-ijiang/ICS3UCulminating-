//
//  ContentView.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 1/6/2026.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Stored properties
    var store = MockDataStore.shared
    
    // MARK: - Computed properties
    var body: some View {
        Group {
            switch store.authState {
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
