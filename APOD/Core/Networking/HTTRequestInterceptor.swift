//
//  HTTRequestInterceptor.swift
//  APOD
//
//  Created by Michael Haß on 05.07.25.
//

import Foundation

enum HTTRequestInterceptor {
    typealias Handler = @Sendable (HTTPURLRequestable) -> HTTPURLRequestable

    static func append(queryItems: [URLQueryItem]) -> Handler {
        { request in
            var request = HTTPURLRequest(requestable: request)
            request.query.append(contentsOf: queryItems)
            return request
        }
    }

    static func prefixPath(_ prefix: String) -> Handler {
        { request in
            var request = HTTPURLRequest(requestable: request)
            request.path += prefix
            return request
        }
    }

    static func setContentType(_ contentType: HTTPContentType) -> Handler {
        { request in
            var request = HTTPURLRequest(requestable: request)
            request.contentType = contentType
            return request
        }
    }
}
