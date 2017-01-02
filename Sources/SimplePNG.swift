import Foundation
import CPNG

typealias Pixel = UInt8

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
    
    var width: Int
    var height: Int
    var colorType: ColorType
    var bitDepth: Int
    
    var rows: [[Pixel]]?
    
    init(width: Int,
         height: Int,
         colorType: ColorType,
         bitDepth: Int,
         rows: [[Pixel]]? = nil) {
        
        self.width = width
        self.height = height
        self.colorType = colorType
        self.bitDepth = bitDepth
        self.rows = rows
        
    }
}

extension Image {

    func write(to url: URL) throws {
     
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
        
        guard let rows = rows else {
            throw SimpleImageError.writeError
        }
        
        // write the bytes
        for row in rows {
            png_write_row(ptr, row);
        }

        
        png_write_end(ptr, nil);
        
        fclose(fp)
        
    }
    
}
