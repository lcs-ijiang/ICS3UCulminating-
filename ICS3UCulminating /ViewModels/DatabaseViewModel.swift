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
            print("DATABASE: Successfully fetched users.")
        } catch let error as DecodingError {
            handleDecodingError(error, for: "user")
        } catch {
            self.errorMessage = "Cloud Sync Error (User): \(error.localizedDescription)"
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
            print("DATABASE: Successfully fetched activities.")
        } catch let error as DecodingError {
            handleDecodingError(error, for: "activity")
        } catch {
            self.errorMessage = "Cloud Sync Error (Activity): \(error.localizedDescription)"
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
            print("DATABASE: Successfully fetched interests.")
        } catch let error as DecodingError {
            handleDecodingError(error, for: "interest")
        } catch {
            self.errorMessage = "Cloud Sync Error (Interest): \(error.localizedDescription)"
        }
        self.isLoading = false
    }
    
    func refreshCloudData() async {
        await fetchUsers()
        await fetchActivities()
        await fetchInterests()
    }
    
    // MARK: - Helper for Detailed DecodingError Logging
    private func handleDecodingError(_ error: DecodingError, for table: String) {
        var message = "Decoding Error in '\(table)' table: "
        
        switch error {
        case .typeMismatch(let type, let context):
            message += "Type mismatch for key '\(context.codingPath.last?.stringValue ?? "unknown")'. Expected \(type)."
        case .valueNotFound(let type, let context):
            message += "Value not found for key '\(context.codingPath.last?.stringValue ?? "unknown")' of type \(type)."
        case .keyNotFound(let key, _):
            message += "Key '\(key.stringValue)' not found in database record."
        case .dataCorrupted(let context):
            message += "Data corrupted at '\(context.codingPath.last?.stringValue ?? "unknown")'."
        @unknown default:
            message += "Unknown decoding error."
        }
        
        self.errorMessage = message
        print("❌ \(message)")
        print("Detailed Context: \(error)")
    }
}
