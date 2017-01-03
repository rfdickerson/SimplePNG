import Foundation
import CPNG

public typealias Bitmap = [[Pixel]]

public enum Pixel {
    
    case srgb(Float, Float, Float)
    case rgb(UInt8, UInt8, UInt8)
    case rgba(UInt8, UInt8, UInt8, UInt8)
    case gray(Float)
    
    init(red: Float, green: Float, blue: Float) {
        self = .srgb(red, green, blue)
    }
    
}

extension Pixel {
    public var bytes: [UInt8] {
        switch self {
        case .srgb(let r, let g, let b):
            return [UInt8(pow(r,2.2)*255), UInt8(pow(g,2.2)*255), UInt8(pow(b,2.2)*255)]
        case .rgb(let r, let g, let b):
            return [r, g, b]
        case .rgba(let r, let g, let b, let a):
            return [r,g,b,a]
        case .gray(let v):
            return [UInt8(v*255)]
        }
    }
}

enum SimpleImageError: Error {
    case writeError
    case readError
}

public enum ColorType {
    
    case grey
    case rgb
    
    var value: Int32 {
        switch self {
        case .grey:
            return PNG_COLOR_TYPE_GRAY
        case .rgb:
            return PNG_COLOR_TYPE_RGB
        }
    }
}

public class Image {
    
    public var width: Int
    public var height: Int
    public var colorType: ColorType
    public var bitDepth: Int
    
    var bitmap: Bitmap?
    
    public init(width: Int,
                height: Int,
                colorType: ColorType,
                bitDepth: Int,
                bitmap: Bitmap? = nil) {
        
        self.width = width
        self.height = height
        self.colorType = colorType
        self.bitDepth = bitDepth
        self.bitmap = bitmap
        
    }
}

extension Image {
    
    public func write(to url: URL) throws {
        
        let fp = fopen(url.relativeString, "wb")
        
        let pngPtr = png_create_write_struct(PNG_LIBPNG_VER_STRING, nil, nil, nil);
        
        guard let ptr = pngPtr else {
            throw SimpleImageError.writeError
        }
        
        let info_ptr = png_create_info_struct(ptr);
        
        png_init_io(ptr, fp);
        // png_set_sig_bytes(ptr, 8)
        
        png_set_IHDR(ptr,
                     info_ptr,
                     png_uint_32(width),
                     png_uint_32(height),
                     Int32(bitDepth),
                     colorType.value,
                     PNG_INTERLACE_NONE,
                     PNG_COMPRESSION_TYPE_DEFAULT,
                     PNG_FILTER_TYPE_DEFAULT);
        
        png_write_info(ptr, info_ptr);
        
        // var bitmapData = [[UInt8]]()
        
        // Convert pixels to byte-array
        let bitmapData: [[UInt8]] = bitmap.flatMap { row in
            
            row.map { pixels in
                
                pixels.flatMap {
                    $0.bytes
                }
                
            }
            
            }!
        
        // write the bytes
        for row in bitmapData {
            png_write_row(ptr, row);
        }
        
        
        png_write_end(ptr, nil);
        
        fclose(fp)
        
    }
    
}
