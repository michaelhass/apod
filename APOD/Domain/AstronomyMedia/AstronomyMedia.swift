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
    @Published
    private(set) var videoOfTheDay: VideoResource?

    private let mediaService: AstronomyMediaService

    init(mediaService: AstronomyMediaService) {
        self.mediaService = mediaService
    }

    func fetchMedia(for date: Date) async throws {
        do {
            let mediaOfTheDay = try await mediaService.fetchMedia(for: date)
            try Task.checkCancellation()

            videoOfTheDay = if mediaOfTheDay.mediaType == .video {
                .init(url: mediaOfTheDay.url)
            } else {
                nil
            }
            self.mediaOfTheDay = mediaOfTheDay
        } catch {
            guard !(error is CancellationError) && !Task.isCancelled else {
                return
            }
            throw error
        }
    }
}
