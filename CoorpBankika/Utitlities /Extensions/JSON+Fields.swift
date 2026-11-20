//
//  JSON+Fields.swift
//  CoorpBankika
//
//  Created by Wycliff Njenga on 20/11/2026.
//

import Foundation
import SwiftyJSON

extension JSON {
    /// The string under `key`, or an error naming the field that was missing or wrong.
    func requiredString(_ key: String) throws -> String {
        let value = self[key]
        guard value.exists() else { throw JSONModelError.missing(field: key) }
        guard let string = value.string else { throw JSONModelError.invalid(field: key) }
        return string
    }

    /// The number under `key`, or an error naming the field that was missing or wrong.
    func requiredDouble(_ key: String) throws -> Double {
        let value = self[key]
        guard value.exists() else { throw JSONModelError.missing(field: key) }
        guard let number = value.double else { throw JSONModelError.invalid(field: key) }
        return number
    }
}
