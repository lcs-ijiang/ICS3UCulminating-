//
//  CreateActivityViewModel.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 1/6/2026.
//

import Foundation
import Observation
import Supabase

@Observable
@MainActor
class CreateActivityViewModel {
    
    // MARK: - Stored properties
    var description: String = ""
    var community: String = "Campus Main"
    var isLoading: Bool = false
    
    // MARK: - Functions
    
    func submitActivity() async {
        guard !description.isEmpty, let currentUser = AuthManager.shared.currentUser else { return }
        
        let newActivity = NewActivity(
            description: description,
            date: Date(),
            community: community,
            max: nil,
            currentParticipants: 1,
            creator_id: currentUser.id
        )
        
        do {
            isLoading = true
            try await supabase
                .from("activity")
                .insert(newActivity)
                .execute()
            
            print("DATABASE: Successfully posted activity.")
        } catch {
            print("DATABASE ERROR: \(error.localizedDescription)")
        }
        isLoading = false
    }
}
