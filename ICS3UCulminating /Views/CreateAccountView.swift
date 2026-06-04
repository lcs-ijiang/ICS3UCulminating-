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
                    Text("Create an account to start matching with other students.")
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)
                
                VStack(spacing: 20) {
                    // Basic Info Section
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Personal Information")
                            .font(.headline)
                        
                        CustomTextField(placeholder: "Full Name", text: $viewModel.fullName)
                        CustomTextField(placeholder: "Email Address", text: $viewModel.email)
                        CustomTextField(placeholder: "Student ID", text: $viewModel.studentID)
                        CustomTextField(placeholder: "Phone Number (Optional)", text: $viewModel.phoneNumber)
                    }
                    
                    // Interests Section
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Choose Your Interests")
                            .font(.headline)
                        
                        TagCloudView(
                            tags: viewModel.availableInterests,
                            selectedTags: viewModel.selectedInterests,
                            onToggle: viewModel.toggleInterest
                        )
                    }
                }
                .padding()
                .background(Color(white: 0.98))
                .cornerRadius(20)
                .padding(.horizontal)
                
                Button(action: {
                    viewModel.createAccount()
                }) {
                    Text("Create Account & Sign In")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(15)
                }
                .padding(.horizontal)
                .padding(.top, 10)
                .disabled(viewModel.fullName.isEmpty || viewModel.email.isEmpty || viewModel.studentID.isEmpty)
                
                Spacer()
            }
            .padding(.vertical)
        }
        .navigationTitle("Create Account")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Subviews
struct TagCloudView: View {
    let tags: [String]
    let selectedTags: [String]
    let onToggle: (String) -> Void
    
    var body: some View {
        // We'll use a LazyVGrid for simplicity in this project
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

// Updating CreateAccountView to use TagCloudView
#Preview {
    NavigationStack {
        CreateAccountView()
    }
}
