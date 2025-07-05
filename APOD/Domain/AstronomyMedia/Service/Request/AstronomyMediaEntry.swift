//
//  AstronomyMediaEntry.swift
//  APOD
//
//  Created by Michael Haß on 05.07.25.
//

import Foundation

struct AstronomyMediaEntry: Decodable {
    let title: String
    let url: URL
    let date: Date
    let mediaType: String
    let explanation: String
    let copyright: String
}
