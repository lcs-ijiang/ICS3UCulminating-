//
//  RandomMatchView.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 1/6/2026.
//

import SwiftUI

struct RandomMatchView: View {
    
    // MARK: - Stored properties
    @State var viewModel = RandomMatchViewModel()
    @Environment(\.dismiss) var dismiss
    
    // MARK: - Computed properties
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                if viewModel.isLoading {
                    ProgressView("Searching for matches...")
                        .padding()
                } else if let match = viewModel.currentMatch {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Recommended for You")
                            .font(.headline)
                            .foregroundColor(.blue)
                        
                        Text(match.title)
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text(match.description ?? "No description provided.")
                            .font(.body)
                        
                        Divider()
                        
                        if let creatorId = match.creator_id {
                            Text("Creator ID: \(creatorId.uuidString.prefix(8))...")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(25)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(radius: 10)
                    .padding(.horizontal, 30)
                    
                    Button(action: {
                        Task { await viewModel.findNextMatch() }
                    }) {
                        Label("Next Match", systemImage: "shuffle")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(15)
                            .padding(.horizontal, 30)
                    }
                } else {
                    VStack(spacing: 20) {
                        Image(systemName: "person.fill.questionmark")
                            .font(.system(size: 80))
                            .foregroundColor(.gray)
                        
                        Text("No matches found")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("Try adding more activities to the campus!")
                            .foregroundColor(.secondary)
                        
                        Button("Refresh") {
                            Task { await viewModel.findNextMatch() }
                        }
                        .buttonStyle(.bordered)
                    }
                }
                
                Spacer()
            }
            .navigationTitle("Random Match")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
            .task {
                await viewModel.findNextMatch()
            }
        }
    }
}

#Preview {
    RandomMatchView()
}
