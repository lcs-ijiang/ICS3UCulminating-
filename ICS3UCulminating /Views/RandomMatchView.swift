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
                if let match = viewModel.currentMatch {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Recommended for You")
                            .font(.headline)
                            .foregroundColor(.blue)
                        
                        Text(match.description)
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        HStack {
                            ForEach(match.tags, id: \.self) { tag in
                                Text("#\(tag)")
                                    .font(.caption)
                                    .padding(6)
                                    .background(Color.blue.opacity(0.1))
                                    .cornerRadius(5)
                            }
                        }
                        
                        Divider()
                        
                        Text("Posted by \(match.creatorName)")
                            .font(.subheadline)
                        
                        Text("Available slots: \(match.maxSlots)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding(25)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(radius: 10)
                    .padding(.horizontal, 30)
                    
                    Button(action: {
                        viewModel.findNextMatch()
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
                        
                        Text("Try adding more interests to your profile!")
                            .foregroundColor(.secondary)
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
        }
    }
}

#Preview {
    RandomMatchView()
}
