//
//  User.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 1/6/2026.
//

import Foundation

struct User: Identifiable, Hashable {
    
    // MARK: - Stored properties
    let id: UUID = UUID()
    var full_name: String
    var phone_number: String
    var student_id: String
    var interests: [String]
    
}
