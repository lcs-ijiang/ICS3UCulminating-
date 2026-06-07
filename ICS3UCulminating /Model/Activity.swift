//
//  Activity.swift
//  ICS3UCulminating
//
//  Created by Student on 1/6/2026.
//

import Foundation

/// Strict model for the "activity" table.
struct Activity: Identifiable, Codable, Hashable {
    
    // MARK: - Stored properties
    let id: Int64
    var description: String
    var date: Date
    var community: String
    var max: String?
    var currentParticipants: Int64
    var creator_id: Int64? // Changed to Int64 to match User.id type
    
    // MARK: - Initializer
    init(id: Int64, 
         description: String, 
         date: Date = Date(), 
         community: String, 
         max: String? = nil, 
         currentParticipants: Int64 = 1,
         creator_id: Int64? = nil) {
        self.id = id
        self.description = description
        self.date = date
        self.community = community
        self.max = max
        self.currentParticipants = currentParticipants
        self.creator_id = creator_id
    }
    
    // MARK: - Coding Keys
    enum CodingKeys: String, CodingKey {
        case id
        case description
        case date
        case community
        case max
        case currentParticipants = "current_participants"
        case creator_id
    }
}

/// Helper for creating a new activity.
struct NewActivity: Codable {
    var description: String
    var date: Date
    var community: String
    var max: String?
    var currentParticipants: Int64
    var creator_id: Int64?
    
    enum CodingKeys: String, CodingKey {
        case description
        case date
        case community
        case max
        case currentParticipants = "current_participants"
        case creator_id
    }
}
