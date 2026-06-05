//
//  PlanActivityViewModel.swift
//  ICS3UCulminating
//
//  Created by Student on 1/6/2026.
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
    func fetchRecentActivities() async {
        isLoading = true
        do {
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
        } catch {
            print("PLAN VIEW ERROR: \(error.localizedDescription)")
        }
        isLoading = false
    }
}
