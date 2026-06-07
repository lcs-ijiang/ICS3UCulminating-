//
//  EditProfileViewModel.swift
//  ICS3UCulminating
//
//  Created by Student on 1/6/2026.
//

import Foundation
import Observation
import Supabase

@Observable
@MainActor
class EditProfileViewModel {
    
    // MARK: - Stored properties
    var fullName: String = ""
    var email: String = ""
    var phoneNumber: String = ""
    var studentId: String = ""
    var community: String = ""
    var selectedInterests: [String] = []
    
    var isLoading: Bool = false
    var isSuccess: Bool = false
    
    let availableInterests = ["Study", "Sports", "Gaming", "Art", "Music", "K-Pop", "Cooking", "Coding"]
    
    // MARK: - Initializer
    
    init(user: User) {
        self.fullName = user.fullName
        self.email = user.email
        self.phoneNumber = user.phoneNumber ?? ""
        self.studentId = user.studentId
        self.community = user.community
        
        // Initial fetch of interests from database
        Task {
            await fetchCurrentInterests(for: user.id)
        }
    }
    
    // MARK: - Functions
    
    /// Pulls the existing interest rows for this user from Supabase.
    func fetchCurrentInterests(for userId: Int64) async {
        do {
            let results: [Interest] = try await supabase
                .from("interest")
                .select()
                .eq("user_id", value: String(userId))
                .execute()
                .value
            self.selectedInterests = results.map { $0.tagName }
        } catch {
            print("FETCH INTERESTS ERROR: \(error.localizedDescription)")
        }
    }
    
    func toggleInterest(_ interest: String) {
        if let index = selectedInterests.firstIndex(of: interest) {
            selectedInterests.remove(at: index)
        } else {
            selectedInterests.append(interest)
        }
    }
    
    /// Updates all user info and synchronizes interests in Supabase.
    func saveChanges() async {
        guard let currentUser = AuthManager.shared.currentUser else { return }
        
        isLoading = true
        
        // 1. Update the 'user' table record
        let updatedUser = User(
            id: currentUser.id,
            fullName: fullName,
            email: email,
            phoneNumber: phoneNumber.isEmpty ? nil : phoneNumber,
            studentId: studentId,
            community: community
        )
        
        do {
            try await supabase
                .from("user")
                .update(updatedUser)
                .eq("id", value: String(currentUser.id))
                .execute()
            
            // 2. Synchronize the 'interest' table
            // Step A: Delete old interests for this user
            try await supabase
                .from("interest")
                .delete()
                .eq("user_id", value: String(currentUser.id))
                .execute()
            
            // Step B: Insert the new set of interests
            for interestName in selectedInterests {
                let newRecord = NewInterest(tagName: interestName, userId: currentUser.id)
                try await supabase
                    .from("interest")
                    .insert(newRecord)
                    .execute()
            }
            
            // 3. Update local app state
            AuthManager.shared.currentUser = updatedUser
            isSuccess = true
            print("DATABASE: Profile and Interests updated successfully.")
            
        } catch {
            print("SAVE CHANGES ERROR: \(error.localizedDescription)")
        }
        
        isLoading = false
    }
}
