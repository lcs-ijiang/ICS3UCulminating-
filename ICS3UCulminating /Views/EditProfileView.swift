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
            Section("Personal Information") {
                TextField("Full Name", text: $viewModel.fullName)
                TextField("Email Address", text: $viewModel.email)
                TextField("Phone Number", text: $viewModel.phoneNumber)
            }
            
            if viewModel.isLoading {
                ProgressView("Saving Changes...")
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
        EditProfileView(user: User(id: UUID(), fullName: "Yishan", email: "yishan@example.com", phoneNumber: "123", studentId: "001", community: "Campus"))
    }
}
