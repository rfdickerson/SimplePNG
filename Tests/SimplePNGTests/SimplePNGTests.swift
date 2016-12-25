import XCTest
@testable import SimplePNG

class SimplePNGTests: XCTestCase {
    
    func testWrite() {
        
        let simplePNG = SimplePNG()
        
        let info = PictureInfo(width: 300, height: 200, colorType: ColorType.rgb, bitDepth: 8)
        
        simplePNG.writePNG(info: info)
        
    }


    static var allTests : [(String, (SimplePNGTests) -> () throws -> Void)] {
        return [
            ("testWrite", testWrite),
        ]
    }
}
