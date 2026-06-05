//
//  LoginViewModel.swift
//  Modules
//
//  Created by Varun on 2026-05-30.
//

import Common
import FactoryKit
import LoginDomain
import Observation
import SwiftUI

@MainActor @Observable
public final class LoginViewModel {
    @ObservationIgnored
    @Injected(\.loginRepository) private var loginRepository
    @ObservationIgnored
    @AppStorage("isLoggedIn", store: Container.shared.sharedStorage()) var isLoggedIn = false

    var email: String = ""
    @ObservationIgnored
    var errorMessage: String = ""
    @ObservationIgnored
    var showAlert: Bool = false

    var isValidEmail: Bool {
        let regex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#

        return email.range(
            of: regex,
            options: .regularExpression
        ) != nil
    }

    public init() {}

    public func login() async {
        do {
            try await loginRepository.login(email: email)
            isLoggedIn = true
        } catch {
            isLoggedIn = false
            errorMessage = "Something went wrong, Please try later."
            showAlert = true
        }
    }
}
