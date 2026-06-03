//
//  PlanActivityView.swift
//  ICS3UCulminating
//
//  Created by Student on 2/3/2026.
//

import SwiftUI

struct PlanActivityView: View {
    
    // MARK: - Stored properties
    @State var viewModel = PlanActivityViewModel()
    
    // MARK: - Computed properties
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    
                    // 1. Top Form Section
                    VStack(alignment: .leading, spacing: 15) {
                        HStack {
                            Text("Plan an Activity")
                                .font(.system(size: 32, weight: .bold))
                            
                            Spacer()
                            
                            // Toggle next to "reason" (mapped to activityDescription label here)
                            HStack {
                                Text("All")
                                    .font(.caption)
                                Toggle("", isOn: $viewModel.showAllActivities)
                                    .labelsHidden()
                                    .onChange(of: viewModel.showAllActivities) { oldValue, newValue in
                                        // Handled by NavigationLink or explicit state if needed
                                    }
                            }
                        }
                        .padding(.bottom, 10)

                        Text("What do you want to do?")
                            .font(.title3)
                        
                        TextField("", text: $viewModel.activityDescription)
                            .padding()
                            .border(Color.gray)
                        
                        Text("When?")
                            .font(.title3)
                        
                        TextField("", text: $viewModel.activityDate)
                            .padding()
                            .border(Color.gray)
                        
                        Button(action: {}) {
                            Text("Post")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(width: 140, height: 50)
                                .background(Color.blue.opacity(0.8))
                                .cornerRadius(25)
                        }
                        .padding(.top, 10)
                    }
                    .padding(20)
                    .background(Color.white)
                    .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 5)

                    // 2. Recent Activity Section
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Recent")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.top, 20)

                        ForEach(viewModel.recentActivities) { activity in
                            ActivityRow(activity: activity)
                        }
                    }
                    .padding(.horizontal, 20)
                }
            }
            .background(Color(white: 0.98))
            .navigationDestination(isPresented: $viewModel.showAllActivities) {
                ActivitiesListView()
            }
        }
    }
}

// MARK: - Reusable Activity Row Component
struct ActivityRow: View {
    let activity: Activity
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // Avatar (using first initial of creator)
            Text(String(activity.creatorName.prefix(1)))
                .font(.title2)
                .fontWeight(.bold)
                .frame(width: 50, height: 50)
                .background(Color.blue.opacity(0.3))
                .cornerRadius(10)

            VStack(alignment: .leading, spacing: 2) {
                Text(activity.creatorName)
                    .fontWeight(.bold)
                Text("wants to...")
                    .font(.caption)
                    .foregroundColor(.gray)
                Text(activity.description)
                    .font(.subheadline)
                    .padding(.top, 2)
            }
            
            Spacer()
            
            Button("Join") { }
                .font(.headline)
                .foregroundColor(.white)
                .frame(width: 80, height: 40)
                .background(Color.blue.opacity(0.8))
                .cornerRadius(20)
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.black.opacity(0.1), lineWidth: 1)
        )
        .background(Color.white)
    }
}

#Preview {
    PlanActivityView()
}
