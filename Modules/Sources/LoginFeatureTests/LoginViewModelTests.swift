//
//  LoginViewModelTests.swift
//  Modules
//
//  Created by Varun on 2026-06-01.
//

import CommonTestSupport
import FactoryKit
import FactoryTesting
@testable import LoginFeature
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

    @Test("validate isValidEmail")
    func validateEmail() {
        let invalidEmail1 = "abc@abc"
        let invalidEmail2 = " @xyz.com"
        let invalidEmail3 = "abc.com"
        let validEmail = "abc@xyz.com"

        for item in [invalidEmail1, invalidEmail2, invalidEmail3] {
            subject.email = item
            #expect(subject.isValidEmail == false)
        }

        subject.email = validEmail
        #expect(subject.isValidEmail == true)
    }

    @Test("should update Shared Storage upon successfully login")
    func updateSharedStorageOnLoginSuccess() async throws {
        mockLoginRepository.response = .success

        await subject.login()

        let sharedStorageValue = try #require(mockSharedStorage.value as? Bool)
        #expect(mockSharedStorage.key == "isLoggedIn")
        #expect(sharedStorageValue == true)
        #expect(subject.errorMessage == "")
        #expect(subject.showAlert == false)
    }

    @Test("should set error message, showAlert to true and update Shared Storage to false when login failed with error")
    func shouldSetErrorMessageAndShowAlertOnLoginError() async throws {
        mockLoginRepository.response = .failure(AnyError())

        await subject.login()

        let sharedStorageValue = try #require(mockSharedStorage.value as? Bool)
        #expect(subject.errorMessage == "Something went wrong, Please try later.")
        #expect(subject.showAlert == true)
        #expect(mockSharedStorage.key == "isLoggedIn")
        #expect(sharedStorageValue == false)
    }
}
