import XCTest
@testable import SimplePNG

class SimplePNGTests: XCTestCase {
    
    func testWrite() {

        var rows = [[UInt8]]()
        
        for x in 1...200 {
            
            var row = [UInt8]()
            
            for y in 1...300 {
                
                let red =   Double(y) / 300.0 * 255.0
                let green = Double(x) / 200.0 * 255.0
                let blue = 128.0
                
                row.append(UInt8(red))
                row.append(UInt8(green))
                row.append(UInt8(blue))
                
            }
            
            rows.append(row)
        }
        
        let image = Image(width: 300,
                          height: 200,
                          colorType: ColorType.rgb,
                          bitDepth: 8,
                          rows: rows)
        
        try! image.write(to: URL(fileURLWithPath: "colorimage.png"))
        
    }


    static var allTests : [(String, (SimplePNGTests) -> () throws -> Void)] {
        return [
            ("testWrite", testWrite),
        ]
    }
}
