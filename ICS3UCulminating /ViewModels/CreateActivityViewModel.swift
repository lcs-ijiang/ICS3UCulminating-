//
//  CreateActivityViewModel.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 1/6/2026.
//

import Foundation
import Observation
import Supabase

@Observable
@MainActor
class CreateActivityViewModel {
    
    // MARK: - Stored properties
    var description: String = ""
    var community: String = "Campus Main" // Default value
    var isLoading: Bool = false
    
    // MARK: - Functions
    
    /// This function saves the new activity into the Supabase database.
    func submitActivity() async {
        guard !description.isEmpty, let currentUser = AuthManager.shared.currentUser else { return }
        
        // 1. Create a NEW Activity object (without an ID, Supabase will generate the int8)
        let newActivity = NewActivity(
            description: description,
            date: Date(),
            community: community,
            max: nil, // Optional capacity
            currentParticipants: 1
        )
        
        do {
            isLoading = true
            // 2. Insert into the 'activity' table
            try await supabase
                .from("activity")
                .insert(newActivity)
                .execute()
            
            print("DATABASE: Successfully posted activity.")
            
        } catch {
            print("DATABASE ERROR: \(error.localizedDescription)")
        }
        isLoading = false
    }
}
