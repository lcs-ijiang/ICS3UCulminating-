//
//  EditProfileView.swift
//  ICS3UCulminating
//
//  Created by Student on 1/6/2026.
//

import SwiftUI

struct EditProfileView: View {
    
    // MARK: - Stored properties
    @State var viewModel: EditProfileViewModel
    @Environment(\.dismiss) var dismiss
    
    // MARK: - Initializer
    init(user: User) {
        _viewModel = State(initialValue: EditProfileViewModel(user: user))
    }
    
    // MARK: - Computed properties
    var body: some View {
        Form {
            Section("Account Details") {
                LabeledContent("Full Name") {
                    TextField("Required", text: $viewModel.fullName)
                        .multilineTextAlignment(.trailing)
                }
                
                LabeledContent("Email Address") {
                    TextField("Required", text: $viewModel.email)
                        .multilineTextAlignment(.trailing)
                        .autocapitalization(.none)
                }
                
                LabeledContent("Phone Number") {
                    TextField("Optional", text: $viewModel.phoneNumber)
                        .multilineTextAlignment(.trailing)
                }
            }
            
            Section("Campus Information") {
                LabeledContent("Student ID") {
                    TextField("Required", text: $viewModel.studentId)
                        .multilineTextAlignment(.trailing)
                }
                
                LabeledContent("Community") {
                    TextField("Required", text: $viewModel.community)
                        .multilineTextAlignment(.trailing)
                }
            }
            
            Section("Your Interests") {
                TagCloudView(
                    tags: viewModel.availableInterests,
                    selectedTags: viewModel.selectedInterests,
                    onToggle: viewModel.toggleInterest
                )
                .padding(.vertical, 8)
            }
            
            if viewModel.isLoading {
                HStack {
                    Spacer()
                    ProgressView("Updating your profile...")
                    Spacer()
                }
            }
        }
        .navigationTitle("Edit Profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    Task {
                        await viewModel.saveChanges()
                        if viewModel.isSuccess {
                            dismiss()
                        }
                    }
                }
                .disabled(viewModel.fullName.isEmpty || viewModel.email.isEmpty || viewModel.isLoading)
            }
        }
    }
}

#Preview {
    NavigationStack {
        EditProfileView(user: User(id: 1, fullName: "Yishan", email: "yishan@example.com", phoneNumber: "123", studentId: "2026001", community: "Campus Main"))
    }
}
