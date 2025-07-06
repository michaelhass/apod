import Foundation
import Testing
@testable import APOD

struct URLExtensionsTests {
    @Test(arguments: [
        (URL(string: "https://www.youtube.com/embed/CC7OJ7gFLvE?rel=0")!, true),
        (URL(string: "https://vimeo.com/123456")!, true),
        (URL(string: "https://example.com")!, false)
    ])
    func testURLIsWebVideoResource(testCase: (url: URL, isWeb: Bool)) async throws {
        #expect(testCase.url.isWebVideoResource == testCase.isWeb)
    }
}
