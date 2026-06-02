//
//  ActivitiesListView.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 1/6/2026.
//

import SwiftUI

struct ActivitiesListView: View {
    
    // MARK: - Stored properties
    // This will eventually be replaced by a ViewModel
    let activities = exampleActivities
    
    // MARK: - Computed properties
    var body: some View {
        NavigationStack {
            List(activities) { activity in
                VStack(alignment: .leading) {
                    Text(activity.description)
                        .font(.headline)
                    Text("Posted by \(activity.poster.name)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("CampusConnect")
        }
    }
}

#Preview {
    ActivitiesListView()
}
