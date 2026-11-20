//
//  TargetConfiguration.swift
//  CoorpBankika
//
//  Created by Wycliff Njenga on 20/11/2026.
//

import Foundation

/// Per-environment settings. Each target sets one flag in SWIFT_ACTIVE_COMPILATION_CONDITIONS:
/// DEV (CoorpBankika Dev), UAT (CoorpBankika UAT) or PROD (CoorpBankika).
nonisolated struct TargetConfiguration {

    enum Environment: String, CaseIterable {
        case development
        case uat
        case production

        static let current: Environment = {
            #if DEV
            return .development
            #elseif UAT
            return .uat
            #else
            return .production
            #endif
        }()

        var isProduction: Bool {
            self == .production
        }

        var displayName: String {
            switch self {
            case .development: "Development"
            case .uat: "UAT"
            case .production: "Production"
            }
        }
    }

    struct Database {
        let storeName: String

        static let dev: Self = .init(storeName: "CoorpBankika-Dev")
        static let uat: Self = .init(storeName: "CoorpBankika-UAT")
        static let production: Self = .init(storeName: "CoorpBankika")
    }

    struct Budget {
        let defaultMonthlyLimit: Double
        let currencyCode: String

        static let dev: Self = .init(defaultMonthlyLimit: 200_000, currencyCode: "KSh")
        static let uat: Self = dev
        static let production: Self = dev
    }

    struct Logging {
        let subsystem: String
        let isVerbose: Bool

        static let dev: Self = .init(subsystem: "com.wycliffnjenga.CoorpBankika.dev", isVerbose: true)
        static let uat: Self = .init(subsystem: "com.wycliffnjenga.CoorpBankika.uat", isVerbose: true)
        static let production: Self = .init(subsystem: "com.wycliffnjenga.CoorpBankika", isVerbose: false)
    }

    let environment: Environment
    let database: Database
    let budget: Budget
    let logging: Logging
}

#if (DEV && (UAT || PROD)) || (UAT && PROD)
#error("More than one environment flag is defined in SWIFT_ACTIVE_COMPILATION_CONDITIONS")
#endif

nonisolated extension TargetConfiguration {

    static let shared = configuration(for: Environment.current)

    static let isProduction = Environment.current.isProduction

    static func configuration(for environment: Environment) -> TargetConfiguration {
        switch environment {
        case .development:
            TargetConfiguration(
                environment: .development,
                database: .dev,
                budget: .dev,
                logging: .dev
            )
        case .uat:
            TargetConfiguration(
                environment: .uat,
                database: .uat,
                budget: .uat,
                logging: .uat
            )
        case .production:
            TargetConfiguration(
                environment: .production,
                database: .production,
                budget: .production,
                logging: .production
            )
        }
    }
}
