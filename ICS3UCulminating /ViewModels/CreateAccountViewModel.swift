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
        let newUserID = UUID()
        let newUser = User(
            id: newUserID,
            createdAt: Date(),
            name: name,
            email: email,
            phone_number: phoneNumber.isEmpty ? nil : phoneNumber
        )
        
        do {
            try await supabase
                .from("user")
                .insert(newUser)
                .execute()
            
            for interestName in selectedInterests {
                let interestRecord = NewInterest(name: interestName, user_id: newUserID)
                try await supabase
                    .from("interest")
                    .insert(interestRecord)
                    .execute()
            }
            
            AuthManager.shared.login(user: newUser)
        } catch {
            self.errorMessage = "Could not create account: \(error.localizedDescription)"
            self.isShowingError = true
        }
        isLoading = false
    }
}
