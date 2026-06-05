//
//  ActivitiesListView.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 1/6/2026.
//

import SwiftUI
import Supabase

struct ActivitiesListView: View {
    
    // MARK: - Stored properties
    @State private var activities: [Activity] = []
    @State private var isLoading = false
    
    // MARK: - Computed properties
    var body: some View {
        Group {
            if isLoading {
                ProgressView("Fetching All Activities...")
            } else {
                List(activities) { activity in
                    VStack(alignment: .leading) {
                        Text(activity.title)
                            .font(.headline)
                        Text(activity.description ?? "No description")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        
                        if let creatorId = activity.creator_id {
                            Text("Creator ID: \(creatorId.uuidString.prefix(8))...")
                                .font(.caption2)
                                .monospaced()
                        }
                    }
                }
            }
        }
        .navigationTitle("All Activities")
        .task {
            await fetchAll()
        }
    }
    
    func fetchAll() async {
        isLoading = true
        do {
            let fetched: [Activity] = try await supabase
                .from("activity")
                .select()
                .execute()
                .value
            self.activities = fetched.reversed()
        } catch {
            print("Error fetching all: \(error)")
        }
        isLoading = false
    }
}

#Preview {
    NavigationStack {
        ActivitiesListView()
    }
}
