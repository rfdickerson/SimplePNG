import XCTest
@testable import SimplePNG

class SimplePNGTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(SimplePNG().text, "Hello, World!")
    }


    static var allTests : [(String, (SimplePNGTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
