//
//  RandomMatchViewModel.swift
//  ICS3UCulminating
//
//  Created by Student on 1/6/2026.
//

import Foundation
import Observation
import Supabase

@Observable
@MainActor
class RandomMatchViewModel {
    
    // MARK: - Stored properties
    var currentMatch: Activity?
    var isLoading: Bool = false
    
    // MARK: - Functions
    func findNextMatch() async {
        guard let currentUser = AuthManager.shared.currentUser else { return }
        
        isLoading = true
        do {
            let userInterests: [Interest] = try await supabase
                .from("interest")
                .select()
                .eq("user_id", value: currentUser.id)
                .execute()
                .value
            
            let interestNames = Set(userInterests.map { $0.name.lowercased() })
            
            let allActivities: [Activity] = try await supabase
                .from("activity")
                .select()
                .execute()
                .value
            
            let matches = allActivities.filter { activity in
                let content = (activity.title + (activity.description ?? "")).lowercased()
                let hasOverlap = interestNames.contains { interest in content.contains(interest) }
                return hasOverlap && activity.creator_id != currentUser.id
            }
            
            if !matches.isEmpty {
                self.currentMatch = matches.randomElement()
            } else {
                self.currentMatch = nil
            }
        } catch {
            print("MATCHING CLOUD ERROR: \(error.localizedDescription)")
        }
        isLoading = false
    }
}
