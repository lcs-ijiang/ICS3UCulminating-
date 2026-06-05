//
//  Interest.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 1/6/2026.
//

import Foundation

/// This model represents a category of interest from the 'interests' table.
struct Interest: Identifiable, Codable, Hashable {
    let id: Int
    var name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
