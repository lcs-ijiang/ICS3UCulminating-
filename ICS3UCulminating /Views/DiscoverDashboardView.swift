//
//  DiscoverDashboardView.swift
//  ICS3UCulminating
//
//  Created by Student on 2/3/2026.
//

import SwiftUI

struct DiscoverDashboardView: View {
    
    // MARK: - Stored properties
    @State var viewModel = MainDashboardViewModel()
    @State private var selectedTab = 0 // 0 for Discover, 1 for Matches
    
    // MARK: - Computed properties
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // 1. Custom Header
                HStack {
                    Image(systemName: "person.2.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .padding(8)
                        .overlay(Rectangle().stroke(Color.purple.opacity(0.3), lineWidth: 2))
                        .foregroundColor(.purple)
                    
                    VStack(alignment: .leading) {
                        Text("Campus")
                        Text("Connect")
                    }
                    .font(.headline)
                    .foregroundColor(Color(red: 26/255, green: 35/255, blue: 126/255))
                    
                    Spacer()
                    
                    NavigationLink {
                        SettingsView()
                    } label: {
                        Image(systemName: "gearshape")
                            .font(.title)
                            .foregroundColor(.black)
                    }
                }
                .padding()
                .border(Color.black.opacity(0.1), width: 1)

                // 2. Tab Selector
                Picker("", selection: $selectedTab) {
                    Text("Discover").tag(0)
                    Text("Matches (\(viewModel.activities.count))").tag(1)
                }
                .pickerStyle(.segmented)
                .padding()
                .background(Color(white: 0.95))

                // 3. Random Match Button
                Button(action: {
                    viewModel.isShowingRandomMatch = true
                }) {
                    HStack {
                        Image(systemName: "shuffle")
                        Text("Random Match")
                    }
                    .padding(.horizontal, 25)
                    .padding(.vertical, 12)
                    .background(Color.white)
                    .foregroundColor(.black)
                    .clipShape(Capsule())
                    .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 3)
                }
                .padding(.top, 20)

                // 4. Content List
                if viewModel.isLoading && viewModel.activities.isEmpty {
                    ProgressView("Refreshing Feed...")
                        .padding()
                }
                
                List(viewModel.activities) { activity in
                    VStack(alignment: .leading, spacing: 5) {
                        Text(activity.description)
                            .font(.headline)
                        HStack {
                            Text(activity.community)
                            Spacer()
                            Text("Participants: \(activity.currentParticipants)")
                        }
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 4)
                }
                .listStyle(.plain)
                .refreshable {
                    await viewModel.refreshFeed()
                }
                
                // 5. Add Button
                Button(action: {
                    viewModel.isShowingCreateSheet = true
                }) {
                    Image(systemName: "plus")
                        .font(.system(size: 40, weight: .light))
                        .foregroundColor(.gray)
                        .frame(width: 80, height: 80)
                        .overlay(Circle().stroke(Color.gray, lineWidth: 4))
                }
                .padding(.bottom, 20)
            }
            .sheet(isPresented: $viewModel.isShowingCreateSheet, onDismiss: {
                Task { await viewModel.refreshFeed() }
            }) {
                CreateActivityView()
            }
            .sheet(isPresented: $viewModel.isShowingRandomMatch) {
                RandomMatchView()
            }
            .task {
                await viewModel.refreshFeed()
            }
        }
    }
}

#Preview {
    DiscoverDashboardView()
}
