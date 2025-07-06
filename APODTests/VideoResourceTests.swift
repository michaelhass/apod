import Foundation
import Testing
@testable import APOD

struct VideoResourceTests {
    struct WebResourceExpectation {
        let urlString: String
        let isWebVideo: Bool
    }
    @Test(arguments: [
        WebResourceExpectation(urlString: "https://www.youtube.com/embed/CC7OJ7gFLvE?rel=0", isWebVideo: true),
        WebResourceExpectation(urlString: "https://youtube.de/embed/CC7OJ7gFLvE?rel=0", isWebVideo: true),
        WebResourceExpectation(urlString: "https://duckduckgo.com", isWebVideo: false)
    ])
    func testIsWebResource(expectation: WebResourceExpectation) async throws {
        let resource = VideoResource(urlString: expectation.urlString)
        #expect(resource != nil)
        #expect(resource?.isWebVideo == expectation.isWebVideo)
    }

}
