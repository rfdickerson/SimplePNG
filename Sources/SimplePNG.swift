import CPNG

enum ColorType {
    
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

struct PictureInfo {
    
    let width: Int
    let height: Int
    let colorType: ColorType
    let bitDepth: png_byte
    
}

struct SimplePNG {

    var text = "Hello, World!"
    
    
    func writePNG(info: PictureInfo) {
     
        let row_pointers: [[UInt8]]
        
        let fp = fopen("test.png", "wb")
        
        let pngPtr = png_create_write_struct(PNG_LIBPNG_VER_STRING, nil, nil, nil);
        
        guard let ptr = pngPtr else {
            print("Could not write struct")
            return
        }
        
        let info_ptr = png_create_info_struct(ptr);
        
        png_init_io(ptr, fp);
        png_set_sig_bytes(ptr, 8)
        
        png_set_IHDR(ptr, info_ptr,
                     png_uint_32(info.width), png_uint_32(info.height),
                     Int32(info.bitDepth), info.colorType.value, PNG_INTERLACE_NONE,
                     PNG_COMPRESSION_TYPE_BASE, PNG_FILTER_TYPE_BASE);

        // write the bytes
        png_write_image(ptr, row_pointers);
        
        png_write_end(ptr, nil);
        
        fclose(fp)
        
    }
    
}
