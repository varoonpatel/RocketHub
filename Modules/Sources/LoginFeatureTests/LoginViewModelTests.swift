//
//  LoginViewModelTests.swift
//  Modules
//
//  Created by Varun on 2026-06-01.
//

import CommonTestSupport
import FactoryKit
import FactoryTesting
import LoginFeature
import Testing

@Suite(.container)
@MainActor
struct LoginViewModelTests {
    let subject: LoginViewModel
    let mockLoginRepository: MockLoginRepository
    let mockSharedStorage: MockSharedStgorage

    init() {
        let mockLoginRepository = MockLoginRepository()
        self.mockLoginRepository = mockLoginRepository
        Container.shared.loginRepository.register {
            mockLoginRepository
        }

        let mockStorage = MockSharedStgorage()
        mockSharedStorage = mockStorage
        Container.shared.sharedStorage.register {
            mockStorage
        }

        subject = LoginViewModel()
    }

    @Test("Should update Shared Storage upon successfully login")
    func updateSharedStorageOnLoginSuccess() async throws {
        mockLoginRepository.response = .success

        await subject.login()

        let sharedStorageValue = try #require(mockSharedStorage.value as? Bool)
        #expect(mockSharedStorage.key == "isLoggedIn")
        #expect(sharedStorageValue == true)
    }
}
