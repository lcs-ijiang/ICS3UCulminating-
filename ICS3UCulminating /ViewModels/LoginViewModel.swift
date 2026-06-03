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
    var isAuthenticated = false
    
    // MARK: - Functions
    func signIn() {
        // Basic validation
        if username.isEmpty || password.isEmpty {
            errorMessage = "Please enter both username and password."
            isShowingError = true
            return
        }
        
        // Mock authentication logic
        // In a real app, this would call Supabase
        if username == "student" && password == "password" {
            isAuthenticated = true
            errorMessage = ""
            isShowingError = false
        } else {
            errorMessage = "Invalid username or password."
            isShowingError = true
        }
    }
    
    func createAccount() {
        // Logic for account creation would go here
        print("Create account tapped")
    }
}
