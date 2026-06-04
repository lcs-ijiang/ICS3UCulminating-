//
//  User.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 1/6/2026.
//

import Foundation

/// Represents a user profile in the system.
/// Conforms to Codable for easy mapping to Supabase JSON.
struct User: Identifiable, Hashable, Codable {
    
    // MARK: - Stored properties
    let id: UUID
    var full_name: String
    var phone_number: String
    var student_id: String
    var interests: [String]
    var community_id: String?
    
    // MARK: - Initializer
    init(id: UUID = UUID(), full_name: String, phone_number: String, student_id: String, interests: [String], community_id: String? = nil) {
        self.id = id
        self.full_name = full_name
        self.phone_number = phone_number
        self.student_id = student_id
        self.interests = interests
        self.community_id = community_id
    }
    
    // Coding keys to match database snake_case columns
    enum CodingKeys: String, CodingKey {
        case id
        case full_name
        case phone_number
        case student_id
        case interests
        case community_id
    }
}
