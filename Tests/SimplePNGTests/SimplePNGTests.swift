import XCTest
@testable import SimplePNG

class SimplePNGTests: XCTestCase {
    
    func testWrite() {

        let simplePNG = SimplePNG()
        
        let info = ImageInfo(width: 300, height: 200, colorType: ColorType.rgb, bitDepth: 8)
        
        var rows = [[UInt8]]()
        
        for x in 1...200 {
            
            var row = [UInt8]()
            
            for y in 1...300 {
                
                let red =   Double(y) / 300.0 * 255.0
                let green = Double(x) / 200.0 * 255.0
                //let red = 255.0
                
                row.append(UInt8(red))
                row.append(UInt8(green))
                row.append(128)
                
            }
            
            rows.append(row)
        }
        
        let image = Image(info: info, rows: rows)
        
        simplePNG.write(image: image, to: URL(fileURLWithPath: "colorimage.png"))
        
    }


    static var allTests : [(String, (SimplePNGTests) -> () throws -> Void)] {
        return [
            ("testWrite", testWrite),
        ]
    }
}
