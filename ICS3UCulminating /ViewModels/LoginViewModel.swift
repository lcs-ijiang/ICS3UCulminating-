//
//  LoginViewModel.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 1/6/2026.
//

import Foundation
import Observation
import Supabase

@Observable
@MainActor
class LoginViewModel {
    
    // MARK: - Stored properties
    var username = ""
    var password = ""
    var errorMessage = ""
    var isShowingError = false
    var isLoading = false
    
    // MARK: - Functions
    
    func signIn() async {
        if username.isEmpty || password.isEmpty {
            errorMessage = "Please enter both username and password."
            isShowingError = true
            return
        }
        
        isLoading = true
        print("LOGIN: Searching for user '\(username)' in Supabase...")
        
        do {
            // DIRECT CLOUD QUERY
            let results: [User] = try await supabase
                .from("user")
                .select()
                .eq("full_name", value: username)
                .execute()
                .value
            
            if let userRecord = results.first {
                AuthManager.shared.login(user: userRecord)
                print("LOGIN SUCCESS: \(userRecord.full_name) is now logged in.")
            } else {
                errorMessage = "No profile found with that name. Please create an account."
                isShowingError = true
                print("LOGIN FAILED: User not found.")
            }
            
        } catch {
            errorMessage = "Login Error: \(error.localizedDescription)"
            isShowingError = true
            print("LOGIN CLOUD ERROR: \(error)")
        }
        isLoading = false
    }
}
