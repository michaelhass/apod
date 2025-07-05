//
//  DateFormatter+Defaults.swift
//  APOD
//
//  Created by Michael Haß on 05.07.25.
//

import Foundation

extension DateFormatter {
    static let medium: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
}
