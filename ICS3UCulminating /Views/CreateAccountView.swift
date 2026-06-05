//
//  CreateAccountView.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 1/6/2026.
//

import SwiftUI

struct CreateAccountView: View {
    
    // MARK: - Stored properties
    @State var viewModel = CreateAccountViewModel()
    
    // MARK: - Computed properties
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 25) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Join the Campus")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text("Create an account to start matching.")
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)
                
                VStack(spacing: 20) {
                    Section {
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Profile Details")
                                .font(.headline)
                            
                            CustomTextField(placeholder: "Full Name", text: $viewModel.name)
                            CustomTextField(placeholder: "Email Address", text: $viewModel.email)
                            CustomTextField(placeholder: "Phone (Optional)", text: $viewModel.phoneNumber)
                            CustomTextField(placeholder: "Student ID", text: $viewModel.studentID)
                            CustomTextField(placeholder: "Community", text: $viewModel.community)
                        }
                    }
                    
                    Section {
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Interests")
                                .font(.headline)
                            
                            TagCloudView(
                                tags: viewModel.availableInterests,
                                selectedTags: viewModel.selectedInterests,
                                onToggle: viewModel.toggleInterest
                            )
                        }
                    }
                }
                .padding()
                .background(Color(white: 0.98))
                .cornerRadius(20)
                .padding(.horizontal)
                
                if viewModel.isLoading {
                    ProgressView("Creating Account...")
                        .frame(maxWidth: .infinity)
                } else {
                    Button(action: {
                        Task { await viewModel.createAccount() }
                    }) {
                        Text("Sign Up & Explore")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(15)
                    }
                    .padding(.horizontal)
                    .disabled(viewModel.name.isEmpty || viewModel.email.isEmpty)
                }
                
                Spacer()
            }
            .padding(.vertical)
        }
        .navigationTitle("Create Account")
        .alert("Error", isPresented: $viewModel.isShowingError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(viewModel.errorMessage)
        }
    }
}

// MARK: - Subviews
struct TagCloudView: View {
    let tags: [String]
    let selectedTags: [String]
    let onToggle: (String) -> Void
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], spacing: 10) {
            ForEach(tags, id: \.self) { tag in
                Text(tag)
                    .font(.subheadline)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(selectedTags.contains(tag) ? Color.blue : Color.gray.opacity(0.1))
                    .foregroundColor(selectedTags.contains(tag) ? .white : .primary)
                    .clipShape(Capsule())
                    .onTapGesture {
                        onToggle(tag)
                    }
            }
        }
    }
}

#Preview {
    NavigationStack {
        CreateAccountView()
    }
}
