import Foundation
import Testing
@testable import Server

@Suite("Server Package Tests")
struct ServerTests {

    @Test("Server compiles and can be initialized")
    func testServerCompiles() {
        #expect(true)
    }
}
