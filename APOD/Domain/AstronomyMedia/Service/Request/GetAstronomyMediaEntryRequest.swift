//
//  GetAstronomyMediaRequest.swift
//  APOD
//
//  Created by Michael Haß on 05.07.25.
//

import Foundation

struct GetAstronomyMediaRequest: HTTPURLRequestable {
    let path: String
    let query: [URLQueryItem]

    init(date: String? = nil) {
        self.path = ""
        self.query = date.map { [URLQueryItem(name: "date", value: $0)] } ?? []
    }
}

typealias GetAstronomyMediaResponse = AstronomyMediaEntry
