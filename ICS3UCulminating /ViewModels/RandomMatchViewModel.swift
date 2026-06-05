//
//  RandomMatchViewModel.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 1/6/2026.
//

import Foundation
import Observation
import Supabase

@Observable
@MainActor
class RandomMatchViewModel {
    
    // MARK: - Stored properties
    var currentMatch: Activity?
    var isLoading: Bool = false
    
    // MARK: - Functions
    
    /// This function finds a random activity that matches the current user's interests from the cloud.
    func findNextMatch() async {
        guard let currentUser = AuthManager.shared.currentUser else { 
            print("MATCHING ERROR: No user logged in.")
            return 
        }
        
        isLoading = true
        print("MATCHING: Running interest overlap algorithm against Supabase...")
        
        do {
            // DIRECT CLOUD QUERY
            let allActivities: [Activity] = try await supabase
                .from("activity")
                .select()
                .execute()
                .value
            
            let currentUserInterests = Set(currentUser.interests)
            
            let matches = allActivities.filter { activity in
                let activityTags = Set(activity.interest_tags)
                return !activityTags.isDisjoint(with: currentUserInterests) && activity.creator_id != currentUser.id
            }
            
            if !matches.isEmpty {
                self.currentMatch = matches.randomElement()
                print("MATCHING SUCCESS: Found match '\(currentMatch?.description ?? "")'")
            } else {
                self.currentMatch = nil
                print("MATCHING: No matches found in the cloud.")
            }
            
        } catch {
            print("MATCHING CLOUD ERROR: \(error.localizedDescription)")
        }
        
        isLoading = false
    }
}
