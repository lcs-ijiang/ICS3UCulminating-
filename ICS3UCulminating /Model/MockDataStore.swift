//
//  MockDataStore.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 1/6/2026.
//

import Foundation
import Observation

/// This class is temporarily used for UI prototyping until Supabase integration is finalized.
@Observable
class MockDataStore {
    
    // MARK: - Singleton
    static let shared = MockDataStore()
    
    // MARK: - Stored properties
    var authState: AppAuthState = .loggedOut
    var activities: [Activity] = []
    var currentUser: User
    
    // MARK: - Initializer
    private init() {
        // Default mock user
        self.currentUser = User(
            full_name: "Yishan Jiang",
            phone_number: "416-555-0123",
            student_id: "2026001",
            interests: ["Study", "Gaming", "K-Pop"]
        )
        
        // Mock activities with database-ready fields
        let mockUserID = UUID()
        self.activities = [
            Activity(
                creator_id: mockUserID,
                creatorName: "Peter Parker",
                description: "Library study session for the CS exam",
                interest_tags: ["Study", "CS"],
                maxSlots: 4
            ),
            Activity(
                creator_id: UUID(),
                creatorName: "Gwen Stacy",
                description: "Gaming night - playing Minecraft together",
                interest_tags: ["Gaming", "Fun"],
                maxSlots: 10
            )
        ]
    }
}
