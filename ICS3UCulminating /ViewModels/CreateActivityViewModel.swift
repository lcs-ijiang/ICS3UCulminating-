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
    var title: String = ""
    var description: String = ""
    var isLoading: Bool = false
    
    // MARK: - Functions
    
    /// This function saves the new activity into the Supabase database.
    func submitActivity() async {
        guard !title.isEmpty, !description.isEmpty, let currentUser = AuthManager.shared.currentUser else { return }
        
        // 1. Create a NEW Activity object (without an ID, Supabase will generate one)
        let newActivity = NewActivity(
            title: title,
            description: description,
            creator_id: currentUser.id
        )
        
        do {
            isLoading = true
            // 2. Insert into the 'activity' table
            try await supabase
                .from("activity")
                .insert(newActivity)
                .execute()
            
            print("Successfully posted activity to Supabase")
            
        } catch {
            print("Error posting activity: \(error.localizedDescription)")
        }
        isLoading = false
    }
}
