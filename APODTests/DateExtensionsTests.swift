import Foundation
import Testing
@testable import APOD

struct DateExtensionsTests {

    @Test func testDateIsInSameDayAs() async throws {
        let date1 = Date()
        let date2 = date1
        #expect(date1.isInSameDayAs(date2))
    }
} 
