//
//  EditProfileViewModel.swift
//  ICS3UCulminating
//
//  Created by Student on 1/6/2026.
//

import Foundation
import Observation
import Supabase

@Observable
@MainActor
class EditProfileViewModel {
    
    // MARK: - Stored properties
    var fullName: String = ""
    var email: String = ""
    var phoneNumber: String = ""
    var isLoading: Bool = false
    var isSuccess: Bool = false
    
    // MARK: - Initializer
    init(user: User) {
        self.fullName = user.fullName
        self.email = user.email
        self.phoneNumber = user.phoneNumber ?? ""
    }
    
    // MARK: - Functions
    func saveChanges() async {
        guard let currentUser = AuthManager.shared.currentUser else { return }
        
        isLoading = true
        
        let updatedUser = User(
            id: currentUser.id,
            fullName: fullName,
            email: email,
            phoneNumber: phoneNumber.isEmpty ? nil : phoneNumber,
            studentId: currentUser.studentId,
            community: currentUser.community
        )
        
        do {
            try await supabase
                .from("user")
                .update(updatedUser)
                .eq("id", value: currentUser.id)
                .execute()
            
            AuthManager.shared.currentUser = updatedUser
            isSuccess = true
        } catch {
            print("PROFILE UPDATE ERROR: \(error.localizedDescription)")
        }
        isLoading = false
    }
}
