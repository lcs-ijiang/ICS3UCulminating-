//
//  CreateActivityViewModel.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 1/6/2026.
//

import Foundation
import Observation

@Observable
class CreateActivityViewModel {
    
    // MARK: - Stored properties
    var description: String = ""
    var selectedTags: [String] = []
    var maxSlots: Int = 2
    
    let availableTags = ["Study", "Gaming", "K-Pop", "Sports", "Music", "Social"]
    
    // MARK: - Functions
    
    /// This function adds or removes a tag from the activity being created.
    func toggleTag(_ tag: String) {
        if let index = selectedTags.firstIndex(of: tag) {
            selectedTags.remove(at: index)
        } else {
            selectedTags.append(tag)
        }
    }
    
    /// This function saves the new activity into the shared mock data list.
    func submitActivity() {
        // Ensure there is a description before saving
        guard !description.isEmpty else { return }
        
        // 1. Create a new Activity object using the current user's name and the form data
        let newActivity = Activity(
            creator_id: MockDataStore.shared.currentUser.id,
            creatorName: MockDataStore.shared.currentUser.full_name,
            description: description,
            interest_tags: selectedTags,
            maxSlots: maxSlots
        )
        
        // 2. Add this new activity to the global list in our MockDataStore
        // Because MockDataStore is @Observable, all views watching this list will update instantly
        MockDataStore.shared.activities.append(newActivity)
    }
}
