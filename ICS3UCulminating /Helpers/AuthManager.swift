//
//  AuthManager.swift
//  ICS3UCulminating
//
//  Created by Student on 1/6/2026.
//

import Foundation
import Observation
import Supabase

/// This class manages the global authentication state.
@Observable
class AuthManager {
    static let shared = AuthManager()
    
    var authState: AppAuthState = .loggedOut
    var currentUser: User?
    var isLoading: Bool = false
    
    private init() {
        // We initialize with the current session if it exists
        Task {
            if let session = try? await supabase.auth.session {
                await handleSupabaseAuthUser(session.user)
            }
        }
    }
    
    @MainActor
    func login(user: User) {
        self.currentUser = user
        self.authState = .loggedIn
        print("✅ AUTH: State changed to LOGGED IN for \(user.fullName)")
    }
    
    @MainActor
    func logout() {
        self.currentUser = nil
        self.authState = .loggedOut
        print("🚪 AUTH: State changed to LOGGED OUT")
    }
    
    func handleSupabaseAuthUser(_ authUser: Supabase.User) async {
        await MainActor.run { self.isLoading = true }
        do {
            let results: [User] = try await supabase
                .from("user")
                .select()
                .eq("email", value: authUser.email ?? "")
                .execute()
                .value
            
            if let existingUser = results.first {
                await login(user: existingUser)
            }
        } catch {
            print("❌ AUTH ERROR: \(error.localizedDescription)")
        }
        await MainActor.run { self.isLoading = false }
    }
}
