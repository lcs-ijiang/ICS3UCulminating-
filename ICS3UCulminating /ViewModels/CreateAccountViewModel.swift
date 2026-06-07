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
    var name: String = ""
    var email: String = ""
    var phoneNumber: String = ""
    var studentID: String = ""
    var community: String = "Campus Main"
    var selectedInterests: [String] = []
    
    var isLoading: Bool = false
    var errorMessage: String = ""
    var isShowingError: Bool = false
    
    let availableInterests = ["Study", "Sports", "Gaming", "Art", "Music", "K-Pop", "Cooking", "Coding"]
    
    // MARK: - Functions
    func toggleInterest(_ interest: String) {
        if let index = selectedInterests.firstIndex(of: interest) {
            selectedInterests.remove(at: index)
        } else {
            selectedInterests.append(interest)
        }
    }
    
    func createAccount() async {
        guard !name.isEmpty, !email.isEmpty else {
            self.errorMessage = "Name and Email are required."
            self.isShowingError = true
            return
        }
        
        isLoading = true
        print("DATABASE: Creating account for \(name)...")
        
        // 1. Create a NEW User object (without ID, Supabase handles auto-increment)
        let newUser = NewUser(
            fullName: name,
            email: email,
            phoneNumber: phoneNumber.isEmpty ? nil : phoneNumber,
            studentId: studentID,
            community: community
        )
        
        do {
            // 2. Insert into the 'user' table
            let response: User = try await supabase
                .from("user")
                .insert(newUser)
                .select()
                .single()
                .execute()
                .value
            
            print("DATABASE: User record created with ID \(response.id)")
            
            // 3. Save interests
            for interestName in selectedInterests {
                let interestRecord = NewInterest(tagName: interestName, userId: response.id) // userId is now Int64
                try await supabase
                    .from("interest")
                    .insert(interestRecord)
                    .execute()
            }
            
            // 4. Log in immediately
            AuthManager.shared.login(user: response)
            print("DATABASE: Signup flow complete.")
            
        } catch {
            print("DATABASE SIGNUP ERROR: \(error.localizedDescription)")
            self.errorMessage = "Could not create account: \(error.localizedDescription)"
            self.isShowingError = true
        }
        isLoading = false
    }
}
