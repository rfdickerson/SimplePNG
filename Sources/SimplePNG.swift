import Foundation
import CPNG

typealias Pixel = UInt8

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

public struct ImageInfo {
    
    let width: Int
    let height: Int
    let colorType: ColorType
    let bitDepth: png_byte
    
}

public struct Image {
    let info: ImageInfo
    let rows: [[Pixel]]
}

struct SimplePNG {

    func write(image: Image, to url: URL) {
     
        let info = image.info
        let fp = fopen(url.relativeString, "wb")
        
        let pngPtr = png_create_write_struct(PNG_LIBPNG_VER_STRING, nil, nil, nil);
        
        guard let ptr = pngPtr else {
            print("Could not write struct")
            return
        }
        
        let info_ptr = png_create_info_struct(ptr);
        
        png_init_io(ptr, fp);
        // png_set_sig_bytes(ptr, 8)
        
        print("Color type is \(info.colorType.value)")
        
        png_set_IHDR(ptr,
                     info_ptr,
                     png_uint_32(info.width),
                     png_uint_32(info.height),
                     Int32(info.bitDepth),
                     info.colorType.value,
                     PNG_INTERLACE_NONE,
                     PNG_COMPRESSION_TYPE_DEFAULT,
                     PNG_FILTER_TYPE_DEFAULT);

        png_write_info(ptr, info_ptr);
        
        // write the bytes
        for row in image.rows {
            png_write_row(ptr, row);
        }

        
        png_write_end(ptr, nil);
        
        fclose(fp)
        
    }
    
}
