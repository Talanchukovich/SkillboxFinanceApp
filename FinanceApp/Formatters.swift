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
        formatter.locale = NSLocale.current
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter
    }()
    
    static let dateFormatted: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = Keyes.shared.dateFormat
        formatter.locale = Locale(identifier: Keyes.shared.locale)
        return formatter
    }()
    
    static let expensDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = Keyes.shared.expensDateFormat
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
    var dateFormated: String? {
        Formatter.dateFormatted.string(from: self)
    }
    var expensDateFormated: String {
        Formatter.expensDateFormatter.string(from: self)
    }
}

extension String {
    var filtred: String{
        self.filter{$0 != " " && $0 != "Р"}
    }
    var stringWithSeparator: String {
        let str = Formatter.withSeparator.string(for: Double(self.filtred)) ?? ""
        return str + " Р"
    }
    
    var buttonTitelAttributed: NSAttributedString {
        return NSAttributedString(string: self, attributes: TextAttributes.shared.buttonTitleAttributes)
    }
    func attributed(attributes: [NSAttributedString.Key : Any]?) -> NSAttributedString{
        return NSAttributedString(string: self, attributes: attributes)
    }
}

