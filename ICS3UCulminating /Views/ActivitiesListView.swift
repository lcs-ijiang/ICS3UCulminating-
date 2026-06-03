//
//  ActivitiesListView.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 1/6/2026.
//

import SwiftUI

struct ActivitiesListView: View {
    
    // MARK: - Stored properties
    private var store = MockDataStore.shared
    
    // MARK: - Computed properties
    var body: some View {
        List(store.activities) { activity in
            VStack(alignment: .leading) {
                Text(activity.description)
                    .font(.headline)
                HStack {
                    Text("By \(activity.creatorName)")
                    Spacer()
                    Text("Slots: \(activity.maxSlots)")
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
            }
        }
        .navigationTitle("All Activities")
    }
}

#Preview {
    NavigationStack {
        ActivitiesListView()
    }
}
