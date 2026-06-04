//
//  AppAuthState.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 1/6/2026.
//

import Foundation

/// Defines the possible authentication states of the application.
enum AppAuthState: Codable {
    case loggedOut
    case loggedIn
}
