//
//  User.swift
//  ICS3UCulminating
//
//  Created by Student on 1/6/2026.
//

import Foundation

/// This model represents a user record stored in the 'user' table on Supabase.
/// We use Codable to automatically map JSON columns to these Swift properties.
struct User: Identifiable, Codable, Hashable {
    
    // MARK: - Stored properties
    let id: UUID
    var full_name: String
    var phone_number: String
    var student_id: String
    var interests: [String]
    
    // MARK: - Initializer
    
    /// Creates a new User instance.
    /// - Parameters:
    ///   - id: The unique UUID for this user.
    ///   - full_name: The student's full name.
    ///   - phone_number: Their contact number.
    ///   - student_id: Their unique school ID number.
    ///   - interests: A list of things they like to do.
    init(id: UUID = UUID(), 
         full_name: String, 
         phone_number: String, 
         student_id: String, 
         interests: [String]) {
        self.id = id
        self.full_name = full_name
        self.phone_number = phone_number
        self.student_id = student_id
        self.interests = interests
    }
}
