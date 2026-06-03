//
//  MainDashboardViewModel.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 1/6/2026.
//

import Foundation
import Observation

@Observable
class MainDashboardViewModel {
    
    // MARK: - Stored properties
    var store = MockDataStore.shared
    var isShowingCreateSheet = false
    var isShowingRandomMatch = false
    
    // MARK: - Computed properties
    var activities: [Activity] {
        return store.activities
    }
}
