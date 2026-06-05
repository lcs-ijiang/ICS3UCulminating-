//
//  Interest.swift
//  ICS3UCulminating
//
//  Created by Student on 1/6/2026.
//

import Foundation

/// Strict model for the "interest" table.
struct Interest: Identifiable, Codable, Hashable {
    
    // MARK: - Stored properties
    let id: Int64
    var tagName: String
    var userId: UUID
    var activityId: Int64?
    
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
    var userId: UUID
    var activityId: Int64?
    
    enum CodingKeys: String, CodingKey {
        case tagName = "tag_name"
        case userId = "user_id"
        case activityId = "activity_id"
    }
}
