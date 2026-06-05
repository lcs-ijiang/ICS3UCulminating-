//
//  Activity.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 1/6/2026.
//

import Foundation

/// This model represents a comprehensive activity record stored in the 'activities' table on Supabase.
struct Activity: Identifiable, Codable, Hashable {
    
    // MARK: - Stored properties
    let id: UUID
    var creator_id: UUID
    var creatorName: String
    var description: String
    var requirements: String
    var interest_tags: [String]
    var maxSlots: Int
    var status: String
    
    // MARK: - Initializer
    
    /// Creates a new Activity instance.
    /// - Parameters:
    ///   - id: A unique identifier for the activity (automatically generated).
    ///   - creator_id: The UUID of the user who is posting the activity.
    ///   - creatorName: The display name of the person who created the post.
    ///   - description: A detailed text describing what the hangout is about (e.g., "Soccer at the gym").
    ///   - requirements: Any specific things needed (e.g., "Bring water", "Must know how to play").
    ///   - interest_tags: A list of categories this activity belongs to (e.g., ["Sports", "Fitness"]).
    ///   - maxSlots: The maximum number of people allowed to join this hangout.
    ///   - status: Whether the hangout is currently "Open" or "Full".
    init(id: UUID = UUID(), 
         creator_id: UUID, 
         creatorName: String, 
         description: String, 
         requirements: String = "",
         interest_tags: [String], 
         maxSlots: Int, 
         status: String = "Open") {
        self.id = id
        self.creator_id = creator_id
        self.creatorName = creatorName
        self.description = description
        self.requirements = requirements
        self.interest_tags = interest_tags
        self.maxSlots = maxSlots
        self.status = status
    }
    
    // MARK: - Coding Keys
    enum CodingKeys: String, CodingKey {
        case id
        case creator_id
        case creatorName = "creator_name"
        case description
        case requirements
        case interest_tags
        case maxSlots = "max_slots"
        case status
    }
}
