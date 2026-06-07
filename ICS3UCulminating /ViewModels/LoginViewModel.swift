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
    
    /// This function handles the sign-in process.
    func signIn() async {
        // 1. Basic validation
        let cleanEmail = email.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        if cleanEmail.isEmpty {
            self.errorMessage = "Please enter your email address."
            self.isShowingError = true
            return
        }
        
        self.isLoading = true
        self.errorMessage = ""
        print("DEBUG: Attempting login for email: \(cleanEmail)")
        
        do {
            // 2. Query the 'user' table for a matching email
            let response: [User] = try await supabase
                .from("user")
                .select()
                .eq("email", value: cleanEmail)
                .execute()
                .value
            
            if let userRecord = response.first {
                // SUCCESS: Notify the AuthManager
                print("DEBUG: Login successful for \(userRecord.fullName)")
                AuthManager.shared.login(user: userRecord)
            } else {
                // NO USER FOUND
                self.errorMessage = "No account found with this email. Please create an account first."
                self.isShowingError = true
                print("DEBUG: No user found in database for email \(cleanEmail).")
            }
            
        } catch let error as DecodingError {
            // SPECIFIC DECODING ERROR
            self.errorMessage = "Data Format Error: The database returned an unexpected type. Check your console."
            self.isShowingError = true
            print("❌ DECODING ERROR during login: \(error)")
        } catch {
            // GENERAL NETWORK/SUPABASE ERROR
            self.errorMessage = "Connection Error: \(error.localizedDescription)"
            self.isShowingError = true
            print("❌ LOGIN ERROR: \(error)")
        }
        
        self.isLoading = false
    }
    
    /// Initiates Google OAuth Sign-In using Supabase SDK.
    func signInWithGoogle() async {
        isLoading = true
        do {
            try await supabase.auth.signInWithOAuth(provider: .google)
            print("DEBUG: Google OAuth request sent.")
        } catch {
            self.errorMessage = "Google Login Failed: \(error.localizedDescription)"
            self.isShowingError = true
        }
        isLoading = false
    }
}
