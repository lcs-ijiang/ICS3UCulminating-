//
//  CreateActivityView.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 1/6/2026.
//

import SwiftUI

struct CreateActivityView: View {
    
    // MARK: - Stored properties
    @State var viewModel = CreateActivityViewModel()
    @Environment(\.dismiss) var dismiss
    
    // MARK: - Computed properties
    var body: some View {
        NavigationStack {
            Form {
                Section("Activity Details") {
                    TextEditor(text: $viewModel.description)
                        .frame(height: 100)
                        .overlay(
                            Group {
                                if viewModel.description.isEmpty {
                                    Text("Describe your hangout...")
                                        .foregroundColor(.gray)
                                        .padding(.leading, 5)
                                        .padding(.top, 8)
                                        .allowsHitTesting(false)
                                }
                            },
                            alignment: .topLeading
                        )
                }
                
                Section("Community") {
                    TextField("Community Name", text: $viewModel.community)
                }
            }
            .navigationTitle("New Activity")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Post") {
                        Task {
                            await viewModel.submitActivity()
                            dismiss()
                        }
                    }
                    .disabled(viewModel.description.isEmpty)
                }
            }
        }
    }
}

#Preview {
    CreateActivityView()
}
