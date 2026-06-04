//
//  SupabaseManager.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 1/6/2026.
//

import Foundation
import Supabase

/// A singleton class to manage the Supabase connection throughout the app.
class SupabaseManager {
    
    // MARK: - Singleton
    static let shared = SupabaseManager()
    
    // MARK: - Stored properties
    let client: SupabaseClient
    
    // MARK: - Initializer
    private init() {
        // Shared global initialization using app credentials
        // Note: In a production app, these would be securely managed.
        self.client = SupabaseClient(
            supabaseURL: URL(string: "YOUR_SUPABASE_URL")!,
            supabaseKey: "YOUR_SUPABASE_ANON_KEY"
        )
    }
}
