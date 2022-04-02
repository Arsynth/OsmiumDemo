//
// Created by a.sechko on 21.02.2022.
//

import Foundation
import CoreImage
import Metal
import Osmium

extension CIImage {
    func makeTexture(commandBuffer: MTLCommandBuffer? = nil) -> MTLTexture? {
        MaterialUtils.loadTexture(ciImage: self, commandBuffer: commandBuffer)
    }
}

