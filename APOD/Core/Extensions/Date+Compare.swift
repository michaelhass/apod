//
//  Date+Compare.swift
//  APOD
//
//  Created by Michael Haß on 05.07.25.
//

import Foundation

extension Date {
   func isInSameDayAs(_ date: Date) -> Bool {
        Calendar.current.isDate(self, inSameDayAs: date)
    }
}
