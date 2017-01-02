# SimplePNG

A simple PNG image library for Swift.

## Features

- Write PNG files

## General usage:

```swift
let image = Image(width: 300,
                  height: 200,
                  colorType: ColorType.rgb,
                  bitDepth: 8,
                  rows: rows)
        
try! image.write(to: URL(fileURLWithPath: "colorimage.png"))
```

The image data is stored in an array of rows. Each row is an array of bytes.