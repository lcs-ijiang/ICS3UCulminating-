//
//  User.swift
//  ICS3UCulminating
//
//  Created by Student on 1/6/2026.
//

import Foundation

/// Strict model for the "user" table.
struct User: Identifiable, Codable, Hashable {
    
    // MARK: - Stored properties
    let id: UUID
    var fullName: String
    var email: String
    var phoneNumber: String?
    var studentId: String
    var community: String
    
    // MARK: - Initializer
    init(id: UUID = UUID(), 
         fullName: String, 
         email: String, 
         phoneNumber: String? = nil,
         studentId: String,
         community: String) {
        self.id = id
        self.fullName = fullName
        self.email = email
        self.phoneNumber = phoneNumber
        self.studentId = studentId
        self.community = community
    }
    
    // MARK: - Coding Keys
    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case email
        case phoneNumber = "phone_number"
        case studentId = "student_id"
        case community
    }
}
