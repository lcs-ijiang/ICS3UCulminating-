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
                        .frame(height: 80)
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
                    
                    TextField("Requirements (optional)", text: $viewModel.requirements)
                }
                
                Section("Tags") {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModel.availableTags, id: \.self) { tag in
                                Text(tag)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .background(viewModel.selectedTags.contains(tag) ? Color.blue : Color.gray.opacity(0.2))
                                    .foregroundColor(viewModel.selectedTags.contains(tag) ? .white : .black)
                                    .clipShape(Capsule())
                                    .onTapGesture {
                                        viewModel.toggleTag(tag)
                                    }
                            }
                        }
                    }
                }
                
                Section("Availability") {
                    Stepper("Max Slots: \(viewModel.maxSlots)", value: $viewModel.maxSlots, in: 1...20)
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
