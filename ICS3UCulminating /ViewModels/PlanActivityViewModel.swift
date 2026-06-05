//
//  PlanActivityViewModel.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 1/6/2026.
//

import Foundation
import Observation
import Supabase

@Observable
@MainActor
class PlanActivityViewModel {
    
    // MARK: - Stored properties
    var activityDescription: String = ""
    var activityDate: String = "2/12/2025"
    var showAllActivities: Bool = false
    var recentActivities: [Activity] = []
    var isLoading: Bool = false
    
    // MARK: - Functions
    
    /// This function fetches the most recent activities from the cloud.
    func fetchRecentActivities() async {
        isLoading = true
        print("PLAN VIEW: Fetching recent activities from Supabase...")
        do {
            // DIRECT CLOUD QUERY
            let all: [Activity] = try await supabase
                .from("activity")
                .select()
                .execute()
                .value
            
            if all.count >= 2 {
                self.recentActivities = Array(all.suffix(2)).reversed()
            } else {
                self.recentActivities = all.reversed()
            }
            print("PLAN VIEW SUCCESS: Loaded \(recentActivities.count) recent items.")
        } catch {
            print("PLAN VIEW ERROR: \(error.localizedDescription)")
        }
        isLoading = false
    }
}
