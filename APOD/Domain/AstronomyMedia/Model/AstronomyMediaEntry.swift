//
//  AstronomyMediaEntry.swift
//  APOD
//
//  Created by Michael Haß on 05.07.25.
//

import Foundation

struct AstronomyMediaEntry: Codable, Sendable {
    let title: String
    let url: URL
    let date: Date
    let mediaType: AstronomyMediaType
    let explanation: String
    let copyright: String?
    let thumbnailUrl: URL?
}

extension AstronomyMediaEntry {
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.url = try container.decode(URL.self, forKey: .url)
        self.date = try container.decode(Date.self, forKey: .date)
        self.mediaType = (try? container.decode(AstronomyMediaType.self, forKey: .mediaType)) ?? .unkown
        self.explanation = try container.decode(String.self, forKey: .explanation)
        self.copyright = try container.decodeIfPresent(String.self, forKey: .copyright)
        self.thumbnailUrl = try container.decodeIfPresent(URL.self, forKey: .thumbnailUrl)
    }
}
