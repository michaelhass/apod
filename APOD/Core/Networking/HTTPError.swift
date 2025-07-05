//
//  HTTPError.swift
//  APOD
//
//  Created by Michael Haß on 05.07.25.
//

import Foundation

struct HTTPError: Error {
    let error: String
    let message: String?

    var description: String {
        let text = "error: \(error)"
        return message.map { text + ", message: '\($0)'" } ?? text
    }
}

extension HTTPError {
    static func badURL(message: String? = nil) -> HTTPError {
        .init(error: "'badURL'", message: message)
    }
}
