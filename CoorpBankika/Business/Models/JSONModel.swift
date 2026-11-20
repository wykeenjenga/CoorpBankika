//
//  JSONModel.swift
//  CoorpBankika
//
//  Created by Wycliff Njenga on 20/11/2026.
//

import Foundation
import SwiftyJSON

/// Every data model is read from and written to JSON with SwiftyJSON.
protocol JSONModel {
    init(from json: JSON) throws
    var json: JSON { get }
}

nonisolated enum JSONModelError: Error, Equatable {
    case missing(field: String)
    case invalid(field: String)
}
