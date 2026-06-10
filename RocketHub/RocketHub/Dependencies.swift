//
//  Dependencies.swift
//  RocketHub
//
//  Created by Varun on 2026-05-25.
//

import Common
import CommonTestSupport
import FactoryKit
import Foundation
import GraphQLClient
import GraphQLClientTestSupport
import HomeData
import HomeDomain
import LoginData

extension Container: @retroactive AutoRegistering {
    public func autoRegister() {
        graphQLClient.register {
            let url = URL(string: String("https://apollo-fullstack-tutorial.herokuapp.com/graphql"))
            return DefaultGraphQLClient(url: url)
        }.onTest { _ in
            MockGraphQLClient()
        }

        logger.register {
            AppLogger()
        }

        loginRepository.register {
            GraphQLLoginRepository()
        }.onTest { _ in
            GraphQLLoginRepository()
        }

        sharedStorage.register {
            SharedStgorage()
        }.onTest { _ in
            MockSharedStgorage()
        }

        launchesRepository.register {
            GraphQLLaunchesRepository()
        }
    }
}
