//
//  MainDashboardViewModel.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 1/6/2026.
//

import Foundation
import Observation
import Supabase

@Observable
@MainActor
class MainDashboardViewModel {
    
    // MARK: - Stored properties
    var activities: [Activity] = []
    var isShowingCreateSheet = false
    var isShowingRandomMatch = false
    var isLoading = false
    
    // MARK: - Functions
    
    /// This function fetches the live activity feed from Supabase.
    func refreshFeed() async {
        print("DASHBOARD: Refreshing feed from Supabase...")
        isLoading = true
        do {
            // DIRECT CLOUD QUERY
            let fetched: [Activity] = try await supabase
                .from("activity")
                .select()
                .execute()
                .value
            
            self.activities = fetched.reversed() // Show newest first
            print("DASHBOARD SUCCESS: Loaded \(activities.count) activities.")
        } catch {
            print("DASHBOARD ERROR: \(error.localizedDescription)")
        }
        isLoading = false
    }
}
