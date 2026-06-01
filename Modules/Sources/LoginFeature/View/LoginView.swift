//
//  LoginView.swift
//  Modules
//
//  Created by Varun on 2026-05-30.
//

import SwiftUI

public struct LoginView: View {
    @State private var viewModel: LoginViewModel = .init()

    public init() {}

    public var body: some View {
        VStack(spacing: 20) {
            HStack {
                TextField("Email", text: $viewModel.email)
                    .keyboardType(.emailAddress)
            }
            .frame(height: 50)
            .padding(4)
            .cornerRadius(8)
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.gray, lineWidth: 1)
            }

            Button {
                Task {
                    await viewModel.login()
                }
            } label: {
                Text("Login")
                    .frame(maxWidth: .infinity)
            }
            .disabled(!viewModel.isValidEmail)
            .frame(height: 50)
            .foregroundStyle(.white)
            .background(viewModel.isValidEmail ? Color.blue : .gray)
            .cornerRadius(8)
        }

        .padding(.horizontal, 20)
    }
}

#Preview {
    LoginView()
}
