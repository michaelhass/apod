import Foundation
import Testing
@testable import APOD

struct StringExtensionsTests {
    @Test func testStringRemovedLineBreaks() async throws {
        let s = "\nHello\nWorld"
        #expect(s.removedLineBreaks == "HelloWorld")
    }
} 
