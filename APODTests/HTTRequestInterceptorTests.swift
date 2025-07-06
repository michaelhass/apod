import Foundation
import Testing
@testable import APOD

struct HTTRequestInterceptorTests {
    @Test func testHTTRequestInterceptorAppend() async throws {
        struct Dummy: HTTPURLRequestable {
            var path: String = "/foo"
            var query: [URLQueryItem] = []
        }
        let handler = HTTRequestInterceptor.append(queryItems: [URLQueryItem(name: "a", value: "b")])
        let dummy = Dummy()
        let result = handler(dummy)
        #expect(result.query.contains { $0.name == "a" && $0.value == "b" })
    }
} 
