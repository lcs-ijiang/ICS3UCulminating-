//
//  Activity.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 1/6/2026.
//

import Foundation

struct Activity: Identifiable {
    
    // MARK: - Stored properties
    let id: UUID = UUID()
    var description: String
    var date: Date
    var poster: User
    
}

// MARK: - Examples
let studySession = Activity(
    description: "Go to library and study for Computer Science",
    date: Date(),
    poster: peter
)

let soccerMatch = Activity(
    description: "Pickup soccer game at the field",
    date: Date().addingTimeInterval(3600),
    poster: gwen
)

let exampleActivities = [studySession, soccerMatch]
