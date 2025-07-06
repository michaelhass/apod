import Foundation
import Testing
@testable import APOD

struct AstronomyMediaEnvironmentTest {
    @Test func testAPODEnvironmentProd() async throws {
        let env = AstronomyMediaEnvironment.prod(apiKey: "test")
        #expect(env.baseURL.absoluteString == "https://api.nasa.gov")
        #expect(env.prefixPath == "/planetary/apod")
        #expect(env.apiKey == "test")
    }
} 
