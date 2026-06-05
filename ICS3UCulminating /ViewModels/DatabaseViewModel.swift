//
//  DatabaseViewModel.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 1/6/2026.
//

import Foundation
import Observation
import Supabase

// MARK: - Supabase Configuration
let supabaseURL = URL(string: "https://wbrpsjwtskjtogwdrpub.supabase.co")!
 
let supabase = SupabaseClient(
    supabaseURL: supabaseURL,
    supabaseKey: "sb_publishable_ocyXB2OBQZmJQVeZSFgPYw_au2EBT1n",
    options: SupabaseClientOptions(
        auth: .init(
            emitLocalSessionAsInitialSession: true
        )
    )
)

// MARK: - Auth Manager
@Observable
class AuthManager {
    static let shared = AuthManager()
    var authState: AppAuthState = .loggedOut
    var currentUser: User?
    private init() {}
    
    func login(user: User) {
        self.currentUser = user
        self.authState = .loggedIn
    }
    
    func logout() {
        self.currentUser = nil
        self.authState = .loggedOut
    }
}

// MARK: - Database ViewModel
@Observable
@MainActor
class DatabaseViewModel {
    
    var users: [User] = []
    var activities: [Activity] = []
    var interests: [Interest] = []
    
    var isLoading: Bool = false
    var errorMessage: String? = nil
    
    func fetchUsers() async {
        self.isLoading = true
        self.errorMessage = nil
        do {
            self.users = try await supabase
                .from("user")
                .select()
                .execute()
                .value
            print("FETCH SUCCESS: Got \(users.count) users from Supabase.")
        } catch {
            self.errorMessage = "Profiles Sync Error: \(error.localizedDescription)"
            print("FETCH ERROR (Profiles): \(error)")
        }
        self.isLoading = false
    }
    
    func fetchActivities() async {
        self.isLoading = true
        self.errorMessage = nil
        do {
            self.activities = try await supabase
                .from("activity")
                .select()
                .execute()
                .value
            print("FETCH SUCCESS: Got \(activities.count) activities from Supabase.")
        } catch {
            self.errorMessage = "Activities Sync Error: \(error.localizedDescription)"
            print("FETCH ERROR (Activities): \(error)")
        }
        self.isLoading = false
    }
    
    func fetchInterests() async {
        self.isLoading = true
        self.errorMessage = nil
        do {
            self.interests = try await supabase
                .from("interest")
                .select()
                .execute()
                .value
            print("FETCH SUCCESS: Got \(interests.count) interests from Supabase.")
        } catch {
            self.errorMessage = "Interests Sync Error: \(error.localizedDescription)"
            print("FETCH ERROR (Interests): \(error)")
        }
        self.isLoading = false
    }
    
    func refreshCloudData() async {
        print("DATABASE SYNC: Starting full cloud refresh...")
        await fetchUsers()
        await fetchActivities()
        await fetchInterests()
    }
}
