import Foundation
import Testing
@testable import APOD

struct HTTPURLRequestTests {
    @Test func testHTTPURLRequestableDefaults() async throws {
        struct Dummy: HTTPURLRequestable {
            var path: String = "/foo"
        }
        let dummy = Dummy()
        let url = URL(string: "https://example.com")!
        let req = try dummy.asURLRequest(baseURL: url)
        #expect(req.url?.absoluteString == "https://example.com/foo")
        #expect(req.httpMethod == "GET")
        #expect(req.value(forHTTPHeaderField: "Content-Type") == "application/json")
    }
} 