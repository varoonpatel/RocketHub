//
//  Logger.swift
//  Modules
//
//  Created by Varun on 2026-05-26.
//

import OSLog

public enum LogLevel {
    case debug
    case info
    case notice
    case error
    case fault
}

public protocol Logging {
    func log(_ message: String, level: LogLevel)
}

public final class AppLogger: Logging {
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier ?? "",
        category: "App"
    )

    public init() {}

    public func log(_ message: String, level: LogLevel) {
        switch level {
        case .debug:
            logger.debug("\(message)")
        case .info:
            logger.info("\(message)")
        case .notice:
            logger.notice("\(message)")
        case .error:
            logger.error("\(message)")
        case .fault:
            logger.fault("\(message)")
        }
    }
}
