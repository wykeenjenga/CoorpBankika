//
//  Date+Formatting.swift
//  CoorpBankika
//
//  Created by Wycliff Njenga on 20/11/2026.
//

import Foundation

extension Date {
    /// e.g. `Nov 27, 2024 12:03 PM`
    var transactionTimestamp: String {
        Self.timestampFormatter.string(from: self)
    }

    /// e.g. `27 November 2024`
    var dayMonthYear: String {
        Self.dayMonthYearFormatter.string(from: self)
    }

    /// e.g. `November`
    var monthName: String {
        formatted(.dateTime.month(.wide))
    }

    private static let timestampFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "MMM d, yyyy h:mm a"
        return formatter
    }()

    private static let dayMonthYearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "d MMMM yyyy"
        return formatter
    }()
}

