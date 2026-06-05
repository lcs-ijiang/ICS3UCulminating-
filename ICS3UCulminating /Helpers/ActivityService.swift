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
    func fetchMatchingActivities(for user: User) async throws -> [Activity] {
        // 1. Fetch all interests for this user from the 'interest' table
        let userInterests: [Interest] = try await supabase
            .from("interest")
            .select()
            .eq("user_id", value: user.id)
            .execute()
            .value
        
        let interestNames = userInterests.map { $0.name }
        
        // 2. Fetch all activities
        let allActivities: [Activity] = try await fetchActivities()
        
        // 3. Match locally (since Supabase doesn't support 'contains' on simple text descriptions easily without array columns)
        return allActivities.filter { activity in
            // Basic matching logic: check if any interest name is mentioned in the activity title or description
            let content = (activity.title + activity.description).lowercased()
            return interestNames.contains { interest in content.contains(interest.lowercased()) }
        }
    }
    
    /// Posts a new activity to the database.
    func createActivity(_ activity: Activity) async throws {
        try await supabase
            .from("activity")
            .insert(activity)
            .execute()
    }
}
