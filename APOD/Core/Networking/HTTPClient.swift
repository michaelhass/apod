//
//  HTTPClient.swift
//  APOD
//
//  Created by Michael Haß on 05.07.25.
//

import Foundation
import OSLog

protocol HTTPClient {
    var interceptors: [HTTRequestInterceptor.Handler] { get }

    func request<T: Decodable>(
        _ requestable: some HTTPURLRequestable,
        for responseType: T.Type,
        decoder: HTTPResponseDecoder
    ) async throws -> T
}

extension HTTPClient {
    func request<T: Decodable>(
        _ requestable: some HTTPURLRequestable,
        for responseType: T.Type
    ) async throws -> T {
        try await request(requestable, for: responseType, decoder: JSONDecoder())
    }
}

final class URLSessionHTTPClient: HTTPClient {
    let baseURL: URL
    let session: URLSession
    let logger: Logger
    let interceptors: [HTTRequestInterceptor.Handler]

    init(
        baseURL: URL,
        session: URLSession = .shared,
        logger: Logger = .init(),
        interceptors: [HTTRequestInterceptor.Handler] = []
    ) {
        self.baseURL = baseURL
        self.session = session
        self.logger = logger
        self.interceptors = interceptors
    }

    func request<T: Decodable>(
        _ requestable: some HTTPURLRequestable,
        for responseType: T.Type,
        decoder: HTTPResponseDecoder
    ) async throws -> T {
        do {
            let request = try interceptors
                .reduce(requestable) { result, interceptor in interceptor(result) }
                .asURLRequest(baseURL: baseURL)
            let (data, _) = try await session.data(for: request)
            return try decoder.decode(T.self, from: data)
        } catch {
            logger.debug("Failed to perform request: \(error)")
            throw error
        }
    }
}

protocol HTTPResponseDecoder {
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable
}

extension JSONDecoder: HTTPResponseDecoder {}

