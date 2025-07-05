//
// URLRequestable.swift
//  APOD
//
//  Created by Michael Haß on 05.07.25.
//
import Foundation

protocol HTTPURLRequestable: Sendable {
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var bodyData: Data? { get }
    var query: [URLQueryItem] { get }
    var timeoutInterval: TimeInterval { get }
    var contentType: HTTPContentType? { get }

    func asURLRequest(baseURL: URL) throws -> URLRequest
}

extension HTTPURLRequestable {
    var httpMethod: HTTPMethod { .get }
    var bodyData: Data? { nil }
    var timeoutInterval: TimeInterval { 30 }
    var contentType: HTTPContentType? { .json }
    var query: [URLQueryItem] { [] }

    func asURLRequest(baseURL: URL) throws -> URLRequest {
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        components?.path = path
        components?.queryItems = query
        guard let url = components?.url else {
            throw HTTPError.badURL(message: "unable to create for \(self)")
        }
        var request = URLRequest(url: url, timeoutInterval: timeoutInterval)
        request.httpMethod = httpMethod.rawValue
        request.httpBody = bodyData
        if let contentType {
            request.setValue(contentType.rawValue, forHTTPHeaderField: "Content-Type")
        }
        return request
    }
}

struct HTTPURLRequest: HTTPURLRequestable {
    var path: String
    var httpMethod: HTTPMethod
    var bodyData: Data?
    var query: [URLQueryItem]
    var timeoutInterval: TimeInterval
    var contentType: HTTPContentType?
}

extension HTTPURLRequest {
    init(requestable: any HTTPURLRequestable) {
        self.path = requestable.path
        self.httpMethod = requestable.httpMethod
        self.bodyData = requestable.bodyData
        self.query = requestable.query
        self.timeoutInterval = requestable.timeoutInterval
        self.contentType = requestable.contentType
    }
}

