//
//  LoginViewModel.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 1/6/2026.
//

import Foundation
import Observation

@Observable
class LoginViewModel {
    
    // MARK: - Stored properties
    var username = ""
    var password = ""
    var errorMessage = ""
    var isShowingError = false
    
    // MARK: - Functions
    
    /// This function handles the sign-in process.
    /// It validates the input fields and checks against mock credentials.
    func signIn() {
        // First, check if the username or password fields are empty
        if username.isEmpty || password.isEmpty {
            // If empty, set the error message and show the alert
            errorMessage = "Please enter both username and password."
            isShowingError = true
            return
        }
        
        // Mock authentication logic:
        // In this prototype, we check if the username is "student" and password is "password"
        if username == "student" && password == "password" {
            // If correct, we "log in" by creating a mock user profile
            MockDataStore.shared.currentUser = User(
                full_name: "Yishan Jiang",
                phone_number: "416-555-0123",
                student_id: "2026001",
                interests: ["Study", "Gaming", "K-Pop"]
            )
            
            // Then we update the global authentication state to 'loggedIn'
            // This triggers the ContentView to switch from the Login screen to the Dashboard
            MockDataStore.shared.authState = .loggedIn
            
            // Clear any previous errors
            errorMessage = ""
            isShowingError = false
        } else {
            // If the credentials don't match our mock data, show an error alert
            errorMessage = "Invalid username or password. (Hint: use student/password)"
            isShowingError = true
        }
    }
}
