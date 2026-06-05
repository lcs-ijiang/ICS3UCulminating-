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
        // Use the shared AuthManager to clear the session
        AuthManager.shared.logout()
    }
}
