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
    func toggleTag(_ tag: String) {
        if let index = selectedTags.firstIndex(of: tag) {
            selectedTags.remove(at: index)
        } else {
            selectedTags.append(tag)
        }
    }
    
    func submitActivity() {
        guard !description.isEmpty else { return }
        
        let newActivity = Activity(
            creatorName: MockDataStore.shared.currentUser.full_name,
            description: description,
            tags: selectedTags,
            maxSlots: maxSlots
        )
        
        MockDataStore.shared.activities.append(newActivity)
    }
}
