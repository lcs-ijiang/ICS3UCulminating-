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
    func findNextMatch() {
        let currentUserInterests = Set(store.currentUser.interests)
        
        // Filter activities that have at least one matching tag with current user's interests
        let matches = store.activities.filter { activity in
            let activityTags = Set(activity.tags)
            return !activityTags.isDisjoint(with: currentUserInterests)
        }
        
        if !matches.isEmpty {
            // Pick a random match, but try to pick a different one than current
            if matches.count > 1 {
                var next = matches.randomElement()
                while next?.id == currentMatch?.id {
                    next = matches.randomElement()
                }
                currentMatch = next
            } else {
                currentMatch = matches.first
            }
        } else {
            currentMatch = nil
        }
    }
}
