//
//  MockDataStore.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 1/6/2026.
//

import Foundation
import Observation

@Observable
class MockDataStore {
    
    // MARK: - Singleton
    static let shared = MockDataStore()
    
    // MARK: - Stored properties
    var activities: [Activity] = []
    var currentUser: User
    
    // MARK: - Initializer
    private init() {
        // Pre-filled current user
        self.currentUser = User(
            full_name: "Yishan Jiang",
            phone_number: "416-555-0123",
            student_id: "2026001",
            interests: ["Study", "Gaming", "K-Pop"]
        )
        
        // Initial mock activities
        self.activities = [
            Activity(
                creatorName: "Peter Parker",
                description: "Library study session for the CS exam",
                tags: ["Study", "CS"],
                maxSlots: 4
            ),
            Activity(
                creatorName: "Gwen Stacy",
                description: "Gaming night - playing Minecraft together",
                tags: ["Gaming", "Fun"],
                maxSlots: 10
            ),
            Activity(
                creatorName: "Miles Morales",
                description: "K-Pop dance practice in the gym",
                tags: ["K-Pop", "Dance"],
                maxSlots: 8
            ),
            Activity(
                creatorName: "Harry Osborn",
                description: "Coffee and networking at the lounge",
                tags: ["Social", "Networking"],
                maxSlots: 5
            )
        ]
    }
}
