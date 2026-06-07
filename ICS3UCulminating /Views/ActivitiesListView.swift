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
    @Environment(\.dismiss) var dismiss
    
    // MARK: - Computed properties
    var body: some View {
        NavigationStack {
            Group {
                if isLoading {
                    ProgressView("Fetching All Activities...")
                } else {
                    List(activities) { activity in
                        VStack(alignment: .leading) {
                            Text(activity.description)
                                .font(.headline)
                            HStack {
                                Text(activity.community)
                                Spacer()
                                if let max = activity.max {
                                    Text("Max: \(max)")
                                }
                            }
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("All Activities")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Return") {
                        dismiss()
                    }
                    .fontWeight(.bold)
                }
            }
            .task {
                await fetchAll()
            }
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
            print("Error fetching all: \(error.localizedDescription)")
        }
        isLoading = false
    }
}

#Preview {
    ActivitiesListView()
}
