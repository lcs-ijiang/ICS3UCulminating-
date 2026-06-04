//
//  SettingsViewModel.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 1/6/2026.
//

import Foundation
import Observation

@Observable
class SettingsViewModel {
    
    // MARK: - Stored properties
    var pushNotificationsEnabled: Bool = true
    var darkModeEnabled: Bool = false
    
    // MARK: - Functions
    
    /// This function handles the user logout process.
    func logout() {
        // 1. Reset the current user profile back to a default "Guest" state
        MockDataStore.shared.currentUser = User(full_name: "Guest", phone_number: "", student_id: "", interests: [])
        
        // 2. Flip the global authentication state back to 'loggedOut'
        // This causes the ContentView to instantly switch back to the Login screen
        MockDataStore.shared.authState = .loggedOut
    }
}
