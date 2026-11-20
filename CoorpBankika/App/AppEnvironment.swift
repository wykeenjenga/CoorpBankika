//
//  AppEnvironment.swift
//  CoorpBankika
//
//  Created by Wycliff Njenga on 20/11/2026.
//

import Foundation

/// Which build is running. Each target sets its own flag in
/// SWIFT_ACTIVE_COMPILATION_CONDITIONS: DEV, UAT or PROD.
enum AppEnvironment: String {
    case dev
    case uat
    case prod

    static var current: AppEnvironment {
        #if DEV
        .dev
        #elseif UAT
        .uat
        #else
        .prod
        #endif
    }

    var displayName: String {
        switch self {
        case .dev: "Development"
        case .uat: "UAT"
        case .prod: "Production"
        }
    }
}
