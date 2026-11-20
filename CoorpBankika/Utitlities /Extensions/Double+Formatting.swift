//
//  Double+Formatting.swift
//  CoorpBankika
//
//  Created by Wycliff Njenga on 20/11/2026.
//

import Foundation

extension Double {
    /// One decimal place with no grouping, e.g. `200000.0`.
    var oneDecimalString: String {
        String(format: "%.1f", self)
    }

    /// Whole amounts drop the decimals, e.g. `2000`; anything else keeps two, e.g. `2000.50`.
    var plainAmountString: String {
        rounded() == self ? String(format: "%.0f", self) : String(format: "%.2f", self)
    }
}
