//
//  String+Extensions.swift
//  APOD
//
//  Created by Michael Haß on 05.07.25.
//

extension String {
    var removedLineBreaks: String {
        self.replacingOccurrences(of: "\n", with: "")
    }
}
