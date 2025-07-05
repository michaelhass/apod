//
//  AstronomyMedia.swift
//  APOD
//
//  Created by Michael Haß on 05.07.25.
//

import Foundation

@MainActor
final class AstronomyMedia: ObservableObject {
    @Published
    private(set) var mediaOfTheDay: AstronomyMediaEntry?

    private let mediaService: AstronomyMediaService

    init(mediaService: AstronomyMediaService) {
        self.mediaService = mediaService
    }

    func fetchMedia(for date: Date) async throws {
        mediaOfTheDay = try await mediaService.fetchMedia(for: date)
    }
}
