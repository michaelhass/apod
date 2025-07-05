//
//  AstronomyMediaService.swift
//  APOD
//
//  Created by Michael Haß on 05.07.25.
//

import Foundation

struct AstronomyMediaService {
    let httpClient: HTTPClient

    static func createDefault(environment: APODEnvironment) -> AstronomyMediaService {
        let interceptors = [
            HTTRequestInterceptor.append(queryItems: [.init(name: "api_key", value: environment.apiKey)]),
            HTTRequestInterceptor.prefixPath(environment.prefixPath),
            HTTRequestInterceptor.setContentType(.json),
        ]
        let httpClient = URLSessionHTTPClient(
            baseURL: environment.baseURL,
            interceptors: interceptors
        )
        return .init(httpClient: httpClient)
    }

    static var responseDecoder: HTTPResponseDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }

    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
}

// MARK: - Requests

extension AstronomyMediaService {

    func fetchMedia(for date: Date) async throws -> GetAstronomyMediaResponse {
        let dateString = Self.dateFormatter.string(from: date)
        let request = GetAstronomyMediaRequest(date: dateString)
        return try await httpClient.request(
            request,
            for: GetAstronomyMediaResponse.self,
            decoder: Self.responseDecoder
        )
    }
}
