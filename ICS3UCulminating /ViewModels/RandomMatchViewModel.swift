//
//  RandomMatchViewModel.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 1/6/2026.
//

import Foundation
import Observation

@Observable
class RandomMatchViewModel {
    
    // MARK: - Stored properties
    private var store = MockDataStore.shared
    var currentMatch: Activity?
    
    // MARK: - Initializer
    init() {
        findNextMatch()
    }
    
    // MARK: - Functions
    
    /// This function finds a random activity that matches the current user's interests.
    /// It filters the list of all activities based on shared tags.
    func findNextMatch() {
        // Get the current user's interests and convert them to a 'Set' for efficient comparison
        let currentUserInterests = Set(store.currentUser.interests)
        
        // Filter the list of all activities
        let matches = store.activities.filter { activity in
            // For each activity, get its tags
            let activityTags = Set(activity.tags)
            
            // Check if there is any overlap between the user's interests and the activity's tags
            // 'isDisjoint' means they have NOTHING in common. '!isDisjoint' means they HAVE something in common.
            return !activityTags.isDisjoint(with: currentUserInterests)
        }
        
        // If we found any matching activities...
        if !matches.isEmpty {
            // If there's more than one match, try to pick a random one that isn't the current one
            if matches.count > 1 {
                var next = matches.randomElement()
                // Keep picking a random element until it's different from the one we are currently showing
                while next?.id == currentMatch?.id {
                    next = matches.randomElement()
                }
                currentMatch = next
            } else {
                // If there's only one match, just show it
                currentMatch = matches.first
            }
        } else {
            // If no activities match the user's interests, set currentMatch to nil
            currentMatch = nil
        }
    }
}
