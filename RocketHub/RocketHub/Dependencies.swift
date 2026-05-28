//
//  Dependencies.swift
//  RocketHub
//
//  Created by Varun on 2026-05-25.
//

import Common
import FactoryKit
import Foundation
import GraphQLClient

extension Container: @retroactive AutoRegistering {
    public func autoRegister() {
        graphQLClient.register {
            let url = URL(string: String("https://apollo-fullstack-tutorial.herokuapp.com/graphql"))
            return DefaultGraphQLClient(url: url)
        }

        logger.register {
            AppLogger()
        }
    }
}
