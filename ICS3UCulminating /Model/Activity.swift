//
//  Activity.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 1/6/2026.
//

import Foundation

/// Represents a hangout post in the system.
/// Conforms to Codable for easy mapping to Supabase JSON.
struct Activity: Identifiable, Hashable, Codable {
    
    // MARK: - Stored properties
    let id: UUID
    var creator_id: UUID
    var creatorName: String // Note: We might pull this via a join in Supabase
    var description: String
    var interest_tags: [String]
    var maxSlots: Int
    var status: String
    
    // MARK: - Initializer
    init(id: UUID = UUID(), creator_id: UUID, creatorName: String, description: String, interest_tags: [String], maxSlots: Int, status: String = "Open") {
        self.id = id
        self.creator_id = creator_id
        self.creatorName = creatorName
        self.description = description
        self.interest_tags = interest_tags
        self.maxSlots = maxSlots
        self.status = status
    }
    
    // Coding keys to match database snake_case columns
    enum CodingKeys: String, CodingKey {
        case id
        case creator_id
        case creatorName = "creator_name" // Mapping database column to Swift property
        case description
        case interest_tags
        case maxSlots = "max_slots"
        case status
    }
}
