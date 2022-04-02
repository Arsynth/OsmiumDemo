//
// Created by a.sechko on 21.02.2022.
//

import Foundation
import CoreImage.CIFilterBuiltins

extension CIImage {

    // Example from https://docs.microsoft.com/en-us/dotnet/api/coreimage.cicheckerboardgenerator?view=xamarin-ios-sdk-12
    static func checkerboard(color0: CIColor = CIColor.green,
                             color1: CIColor = CIColor.black,
                             squareSide: Float = 50.0,
                             center: CGPoint = CGPoint(x: 50.0, y: 50.0),
                             imageSize: CGSize = CGSize(width: 100, height: 100)) -> CIImage {
        let checkerboardFilter = CIFilter.checkerboardGenerator()
        checkerboardFilter.color0 = color0
        checkerboardFilter.color1 = color1
        checkerboardFilter.width = squareSide
        checkerboardFilter.center = center
        return checkerboardFilter.outputImage!.cropped(to: CGRect(origin: .zero, size: imageSize))
    }
}
