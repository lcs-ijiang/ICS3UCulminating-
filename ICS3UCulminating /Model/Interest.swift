//
//  Interest.swift
//  ICS3UCulminating
//
//  Created by Student on 1/6/2026.
//

import Foundation

/// This model strictly matches the "interest" table in Supabase.
/// Fix: Changed 'id' from UUID to Int to match the database's integer primary key.
struct Interest: Identifiable, Codable, Hashable {
    
    // MARK: - Stored properties
    let id: Int // Primary Key is an integer in your Supabase table
    var name: String
    var user_id: UUID? // Optional Foreign Key referencing user.id (which is UUID)
    
    // MARK: - Initializer
    init(id: Int, name: String, user_id: UUID? = nil) {
        self.id = id
        self.name = name
        self.user_id = user_id
    }
    
    // MARK: - Coding Keys
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case user_id
    }
}

/// This helper struct is used when saving a NEW interest.
struct NewInterest: Codable {
    var name: String
    var user_id: UUID
}
