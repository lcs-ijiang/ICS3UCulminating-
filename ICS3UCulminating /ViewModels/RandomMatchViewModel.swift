//
//  RandomMatchViewModel.swift
//  ICS3UCulminating
//
//  Created by Student on 1/6/2026.
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
    func findNextMatch() async {
        guard let currentUser = AuthManager.shared.currentUser else { return }
        
        isLoading = true
        do {
            // 1. Fetch user's interests from the 'interest' table
            // Fix: Converting Int64 to String for the filter to avoid compiler errors
            let userInterests: [Interest] = try await supabase
                .from("interest")
                .select()
                .eq("user_id", value: String(currentUser.id))
                .execute()
                .value
            
            let interestNames = Set(userInterests.map { $0.tagName.lowercased() })
            
            // 2. Fetch all activities from Supabase
            let allActivities: [Activity] = try await supabase
                .from("activity")
                .select()
                .execute()
                .value
            
            // 3. Filter locally: check if any user interest is mentioned in the activity description
            let matches = allActivities.filter { activity in
                let content = activity.description.lowercased()
                let hasOverlap = interestNames.contains { interest in content.contains(interest) }
                // Don't match with your own post
                let notOwnPost = activity.creator_id != currentUser.id 
                return hasOverlap && notOwnPost
            }
            
            if !matches.isEmpty {
                self.currentMatch = matches.randomElement()
            } else {
                self.currentMatch = nil
            }
        } catch {
            print("MATCHING CLOUD ERROR: \(error.localizedDescription)")
        }
        isLoading = false
    }
}
