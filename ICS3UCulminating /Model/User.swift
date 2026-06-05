//
//  User.swift
//  ICS3UCulminating
//
//  Created by Student on 1/6/2026.
//

import Foundation

/// This model represents a user record stored in the 'user' table on Supabase.
/// Fix: Made properties optional to prevent "data missing" errors if columns are null.
struct User: Identifiable, Codable, Hashable {
    
    // MARK: - Stored properties
    let id: UUID
    var createdAt: Date? // Changed to Optional
    var name: String
    var email: String? // Changed to Optional
    var phone_number: String?
    
    // MARK: - Initializer
    init(id: UUID = UUID(), 
         createdAt: Date? = nil, 
         name: String, 
         email: String? = nil, 
         phone_number: String? = nil) {
        self.id = id
        self.createdAt = createdAt
        self.name = name
        self.email = email
        self.phone_number = phone_number
    }
    
    // MARK: - Coding Keys
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case name
        case email
        case phone_number
    }
}
