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
                                profileRows
                            case 1:
                                activityRows
                            case 2:
                                interestRows
                            default:
                                EmptyView()
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
    
    private var profileRows: some View {
        ForEach(viewModel.users) { user in
            VStack(alignment: .leading) {
                Text(user.fullName).font(.headline)
                Text(user.email).font(.subheadline)
                if let phone = user.phoneNumber {
                    Text(phone).font(.caption).foregroundColor(.secondary)
                }
            }
        }
    }
    
    private var activityRows: some View {
        ForEach(viewModel.activities) { act in
            VStack(alignment: .leading) {
                Text(act.description).font(.headline)
                Text("Community: \(act.community)").font(.subheadline)
                Text("Participants: \(act.currentParticipants)").font(.caption2).foregroundColor(.gray)
            }
        }
    }
    
    private var interestRows: some View {
        ForEach(viewModel.interests) { inter in
            VStack(alignment: .leading) {
                Text(inter.tagName)
                Text("User ID: \(String(inter.userId))")
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
        }
    }
}
