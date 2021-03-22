//
//  Formatters.swift
//  FinanceApp
//
//  Created by Андрей Таланчук on 03.03.2021.
//

import Foundation

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        formatter.locale = Locale(identifier: Keyes.shared.locale)
        return formatter
    }()
    
    static let dateFormatted: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = Keyes.shared.dateFormat
        formatter.locale = Locale(identifier: Keyes.shared.locale)
        return formatter
    }()
}

extension Numeric {
    var numbWithSeparator: String {
        Formatter.withSeparator.string(for: self) ?? ""
    }
}

extension Date {
    var dateFormated: String {
        Formatter.dateFormatted.string(from: self)
    }
}

extension String {
    var stringWithSeparator: String {
        Formatter.withSeparator.string(for: Double(self)) ?? ""
    }
}
