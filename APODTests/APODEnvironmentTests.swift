import Foundation
import Testing
@testable import APOD

struct APODEnvironmentTests {
    @Test func testAPODEnvironmentProd() async throws {
        let env = APODEnvironment.prod(apiKey: "test")
        #expect(env.baseURL.absoluteString == "https://api.nasa.gov")
        #expect(env.prefixPath == "/planetary/apod")
        #expect(env.apiKey == "test")
    }
} 