//
//  CreateAccountViewModel.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 1/6/2026.
//

import Foundation
import Observation

@Observable
class CreateAccountViewModel {
    
    // MARK: - Stored properties
    var fullName: String = ""
    var email: String = ""
    var studentID: String = ""
    var phoneNumber: String = ""
    var selectedInterests: [String] = []
    
    let availableInterests = ["Study", "Sports", "Gaming", "Art", "Music", "K-Pop", "Cooking", "Coding"]
    
    // MARK: - Functions
    
    /// This function adds or removes an interest from the user's selected list.
    /// It is called whenever a user taps an interest tag in the UI.
    func toggleInterest(_ interest: String) {
        // Check if the interest is already in our list
        if let index = selectedInterests.firstIndex(of: interest) {
            // If it is, the user wants to remove it, so we delete it at that position
            selectedInterests.remove(at: index)
        } else {
            // If it's not in the list, the user wants to add it
            selectedInterests.append(interest)
        }
    }
    
    /// This function handles the final account creation step.
    /// It creates a new User object and logs them in immediately.
    func createAccount() {
        // Basic safety check: make sure the required fields aren't empty
        guard !fullName.isEmpty, !email.isEmpty, !studentID.isEmpty else { return }
        
        // 1. Create a new User object using the data entered into the form
        let newUser = User(
            full_name: fullName,
            phone_number: phoneNumber,
            student_id: studentID,
            interests: selectedInterests
        )
        
        // 2. Save this new user as the 'currentUser' in our shared data store
        // This ensures the rest of the app knows who is currently logged in
        MockDataStore.shared.currentUser = newUser
        
        // 3. Flip the global authentication state to 'loggedIn'
        // This causes the app's root view (ContentView) to automatically show the Dashboard
        MockDataStore.shared.authState = .loggedIn
    }
}
