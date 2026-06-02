//
//  User.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 1/6/2026.
//

import Foundation

struct User: Identifiable {
    
    // MARK: - Stored properties
    let id: UUID = UUID()
    var name: String
    var phone: String
    var studentID: String
    var interests: [String]
    
}

// MARK: - Examples
let peter = User(
    name: "Peter Parker",
    phone: "416-555-0123",
    studentID: "1001",
    interests: ["Photography", "Science", "K-Pop"]
)

let gwen = User(
    name: "Gwen Stacy",
    phone: "416-555-0456",
    studentID: "1002",
    interests: ["Music", "Science", "Soccer"]
)

let exampleUsers = [peter, gwen]
