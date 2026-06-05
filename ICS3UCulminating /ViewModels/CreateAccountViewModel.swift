//
//  CreateAccountViewModel.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 1/6/2026.
//

import Foundation
import Observation
import Supabase

@Observable
@MainActor
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
    func toggleInterest(_ interest: String) {
        if let index = selectedInterests.firstIndex(of: interest) {
            selectedInterests.remove(at: index)
        } else {
            selectedInterests.append(interest)
        }
    }
    
    /// This function handles the final account creation step by saving to Supabase.
    func createAccount() async {
        guard !fullName.isEmpty, !email.isEmpty else { return }
        
        // 1. Create a new User object
        let newUser = User(
            id: UUID(),
            full_name: fullName,
            phone_number: phoneNumber,
            student_id: studentID,
            interests: selectedInterests
        )
        
        do {
            // 2. Save this new user to the 'user' table in Supabase
            try await supabase
                .from("user")
                .insert(newUser)
                .execute()
            
            // 3. Log in immediately
            AuthManager.shared.login(user: newUser)
            
        } catch {
            print("Error creating account: \(error.localizedDescription)")
        }
    }
}
