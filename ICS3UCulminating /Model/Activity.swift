//
//  Activity.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 1/6/2026.
//

import Foundation

struct Activity: Identifiable, Hashable {
    
    // MARK: - Stored properties
    let id: UUID = UUID()
    var creatorName: String
    var description: String
    var tags: [String]
    var maxSlots: Int
    
}
