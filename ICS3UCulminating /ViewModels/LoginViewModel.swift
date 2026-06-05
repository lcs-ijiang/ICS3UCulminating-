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
    var email = ""
    var errorMessage = ""
    var isShowingError = false
    var isLoading = false
    
    // MARK: - Functions
    
    /// This function handles the sign-in process by checking the email.
    func signIn() async {
        if email.isEmpty {
            errorMessage = "Please enter your email."
            isShowingError = true
            return
        }
        
        isLoading = true
        do {
            let results: [User] = try await supabase
                .from("user")
                .select()
                .eq("email", value: email)
                .execute()
                .value
            
            if let userRecord = results.first {
                AuthManager.shared.login(user: userRecord)
            } else {
                errorMessage = "No account found with that email."
                isShowingError = true
            }
        } catch {
            errorMessage = "Login Error: \(error.localizedDescription)"
            isShowingError = true
        }
        isLoading = false
    }
    
    /// Initiates Google OAuth Sign-In using Supabase SDK.
    func signInWithGoogle() async {
        isLoading = true
        do {
            // EXACT OAUTH PIPELINE REQUEST
            try await supabase.auth.signInWithOAuth(provider: .google)
            print("GOOGLE AUTH: Request sent successfully.")
        } catch {
            self.errorMessage = "Google Login Failed: \(error.localizedDescription)"
            self.isShowingError = true
        }
        isLoading = false
    }
}
