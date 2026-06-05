//
//  Activity.swift
//  ICS3UCulminating
//
//  Created by Student on 1/6/2026.
//

import Foundation

/// This model represents an activity record stored in the 'activity' table on Supabase.
/// Fix: Made properties optional to prevent "data missing" errors.
struct Activity: Identifiable, Codable, Hashable {
    
    // MARK: - Stored properties
    let id: Int 
    var createdAt: Date? // Changed to Optional
    var description: String? // Changed to Optional
    var creator_id: UUID? // Changed to Optional
    
    // MARK: - Initializer
    init(id: Int, 
         createdAt: Date? = nil,
         description: String? = nil, 
         creator_id: UUID? = nil) {
        self.id = id
        self.createdAt = createdAt
  
        self.description = description
        self.creator_id = creator_id
    }
    
    // MARK: - Coding Keys
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
   
        case description
        case creator_id
    }
}

struct NewActivity: Codable {

    var description: String
    var creator_id: UUID
}
