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
    var requirements: String = ""
    var selectedTags: [String] = []
    var maxSlots: Int = 2
    
    let availableTags = ["Study", "Gaming", "K-Pop", "Sports", "Music", "Social"]
    
    // MARK: - Functions
    
    func toggleTag(_ tag: String) {
        if let index = selectedTags.firstIndex(of: tag) {
            selectedTags.remove(at: index)
        } else {
            selectedTags.append(tag)
        }
    }
    
    /// This function saves the new activity into the Supabase database.
    func submitActivity() async {
        guard !description.isEmpty, let currentUser = AuthManager.shared.currentUser else { return }
        
        // 1. Create a new Activity object
        let newActivity = Activity(
            id: UUID(),
            creator_id: currentUser.id,
            creatorName: currentUser.full_name,
            description: description,
            requirements: requirements,
            interest_tags: selectedTags,
            maxSlots: maxSlots
        )
        
        do {
            // 2. Insert into the 'activity' table
            try await supabase
                .from("activity")
                .insert(newActivity)
                .execute()
            
            print("Successfully posted activity to Supabase")
            
        } catch {
            print("Error posting activity: \(error.localizedDescription)")
        }
    }
}
