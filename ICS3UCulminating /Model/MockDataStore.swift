//
//  MockDataStore.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 1/6/2026.
//

import Foundation
import Observation

enum AppAuthState {
    case loggedOut
    case loggedIn
}

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
        // Default empty user or guest
        self.currentUser = User(
            full_name: "Guest",
            phone_number: "",
            student_id: "",
            interests: []
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
