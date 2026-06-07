//
//  Interest.swift
//  ICS3UCulminating
//
//  Created by Student on 1/6/2026.
//

import Foundation

/// This model strictly matches the "interest" table in Supabase.
/// Fix: Changed 'id' and 'userId' to Int64 to match database integer primary keys.
struct Interest: Identifiable, Codable, Hashable {
    
    // MARK: - Stored properties
    let id: Int64 
    var tagName: String
    var userId: Int64 // Matches User.id type
    var activityId: Int64?
    
    // MARK: - Initializer
    init(id: Int64, tagName: String, userId: Int64, activityId: Int64? = nil) {
        self.id = id
        self.tagName = tagName
        self.userId = userId
        self.activityId = activityId
    }
    
    // MARK: - Coding Keys
    enum CodingKeys: String, CodingKey {
        case id
        case tagName = "tag_name"
        case userId = "user_id"
        case activityId = "activity_id"
    }
}

/// Helper for saving a new interest.
struct NewInterest: Codable {
    var tagName: String
    var userId: Int64
    var activityId: Int64?
    
    enum CodingKeys: String, CodingKey {
        case tagName = "tag_name"
        case userId = "user_id"
        case activityId = "activity_id"
    }
}
