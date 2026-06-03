//
//  PlanActivityViewModel.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 1/6/2026.
//

import Foundation
import Observation

@Observable
class PlanActivityViewModel {
    
    // MARK: - Stored properties
    var activityDescription: String = "go to library and study"
    var activityDate: String = "2/12/2025"
    var showAllActivities: Bool = false
    
    private var store = MockDataStore.shared
    
    // MARK: - Computed properties
    var recentActivities: [Activity] {
        // Return the last 2 activities for the "Recent" section
        let all = store.activities
        if all.count >= 2 {
            return Array(all.suffix(2)).reversed()
        } else {
            return all.reversed()
        }
    }
}
