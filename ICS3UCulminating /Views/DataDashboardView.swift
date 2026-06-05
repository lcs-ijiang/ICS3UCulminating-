//
//  DataDashboardView.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 1/6/2026.
//

import SwiftUI

struct DataDashboardView: View {
    @State private var viewModel = DatabaseViewModel()
    @State private var selectedTab = 0 
    
    var body: some View {
        NavigationStack {
            VStack {
                if let error = viewModel.errorMessage {
                    Text(error)
                        .font(.caption)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red.opacity(0.1))
                        .foregroundColor(.red)
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
                
                Picker("Tab", selection: $selectedTab) {
                    Text("Users").tag(0)
                    Text("Activities").tag(1)
                    Text("Interests").tag(2)
                }
                .pickerStyle(.segmented)
                .padding()
                
                ZStack {
                    if viewModel.isLoading && viewModel.users.isEmpty {
                        ProgressView("Loading...")
                    } else {
                        List {
                            switch selectedTab {
                            case 0:
                                ForEach(viewModel.users) { user in
                                    VStack(alignment: .leading) {
                                        Text(user.name).font(.headline)
                                        Text(user.email ?? "No email").font(.subheadline)
                                        if let phone = user.phone_number {
                                            Text(phone).font(.caption).foregroundColor(.secondary)
                                        }
                                    }
                                }
                            case 1:
                                ForEach(viewModel.activities) { act in
                                    VStack(alignment: .leading) {
                                        Text(act.title).font(.headline)
                                        Text(act.description ?? "No description").font(.subheadline)
                                        if let creatorId = act.creator_id {
                                            Text("By: \(creatorId.uuidString.prefix(8))...")
                                                .font(.caption2)
                                                .monospaced()
                                        }
                                    }
                                }
                            case 2:
                                ForEach(viewModel.interests) { inter in
                                    VStack(alignment: .leading) {
                                        Text(inter.name)
                                        if let userId = inter.user_id {
                                            Text("User: \(userId.uuidString.prefix(8))...")
                                                .font(.caption2)
                                                .foregroundColor(.gray)
                                        }
                                    }
                                }
                            default: EmptyView()
                            }
                        }
                    }
                }
            }
            .navigationTitle("Live Data")
            .task {
                await viewModel.refreshCloudData()
            }
        }
    }
}
