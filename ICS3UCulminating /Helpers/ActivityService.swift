//
//  ActivityService.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 1/6/2026.
//

import Foundation
import Supabase

/// Service class to handle all Activity-related database operations.
class ActivityService {
    
    // MARK: - Functions
    
    /// Fetches all open activities from the database.
    func fetchActivities() async throws -> [Activity] {
        let activities: [Activity] = try await supabase
            .from("activity")
            .select()
            .execute()
            .value
        
        return activities
    }
    
    /// Fetches activities that match the current user's interests.
    /// This is the "Matching Algorithm" in action.
    func fetchMatchingActivities(for user: User) async throws -> [Activity] {
        // The 'cs' filter in Supabase checks if an array 'contains' values
        // Here we check if any of the activity's interest_tags are in the user's interests
        let activities: [Activity] = try await supabase
            .from("activity")
            .select()
            .contains("interest_tags", value: user.interests)
            .eq("status", value: "Open")
            .execute()
            .value
        
        // Filter out the user's own posts
        return activities.filter { $0.creator_id != user.id }
    }
    
    /// Posts a new activity to the database.
    func createActivity(_ activity: Activity) async throws {
        try await supabase
            .from("activity")
            .insert(activity)
            .execute()
    }
}
