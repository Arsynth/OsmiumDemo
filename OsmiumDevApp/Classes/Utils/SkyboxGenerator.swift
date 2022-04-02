//
// Created by a.sechko on 27.03.2022.
//

import MetalKit

class SkyboxGenerator {
    struct SkySettings {
        var turbidity: Float = 0.28
        var sunElevation: Float = 0.6
        var upperAtmosphereScattering: Float = 0.1
        var groundAlbedo: Float = 4
    }

    static var skySettings = SkySettings()

    static func loadGeneratedSkyboxTexture(dimensions: SIMD2<Int32>, device: MTLDevice) -> MTLTexture? {
        var texture: MTLTexture?
        let skyTexture = MDLSkyCubeTexture(
                name: "sky",
                channelEncoding: .uInt8,
                textureDimensions: dimensions,
                turbidity: skySettings.turbidity,
                sunElevation: skySettings.sunElevation,
                upperAtmosphereScattering: skySettings.upperAtmosphereScattering,
                groundAlbedo: skySettings.groundAlbedo
        )
        do {
            let textureLoader = MTKTextureLoader(device: device)
            texture = try textureLoader.newTexture(texture: skyTexture, options: nil)
        } catch {
            print(error.localizedDescription)
        }
        return texture
    }
}
