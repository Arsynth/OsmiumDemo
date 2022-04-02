//
//  TestSceneUtils.swift
//  Osmium
//
//  Created by a.sechko on 12.04.2021.
//

import Foundation
import ModelIO
import MetalKit
import CoreGraphics
import Osmium

class TestingUtils {

    static func getCube(withSide side: CGFloat, device: MTLDevice) -> OSMMesh {
        let mdlMesh = MDLMesh(
            boxWithExtent: float3(repeating: Float(side)),
            segments: vector_uint3(repeating: 1),
            inwardNormals: false,
            geometryType: .triangles,
            allocator: MTKMeshBufferAllocator(device: device)
        )
        return OSMMesh(withMDLMesh: mdlMesh, device: device)
    }

    static func getSphere(withSide side: CGFloat, device: MTLDevice) -> OSMMesh {
        let mdlMesh = MDLMesh(
                sphereWithExtent: float3(repeating: Float(side)),
                segments: vector_uint2(repeating: 40),
                inwardNormals: false,
                geometryType: .triangles,
                allocator: MTKMeshBufferAllocator(device: device)
        )
        return OSMMesh(withMDLMesh: mdlMesh, device: device)
    }

    static func getPlane(withExtent extent: float3, textureName: String? = nil, tiling: float2 = [1.0, 1.0], device: MTLDevice) -> OSMMesh {
        let mdlMesh = MDLMesh(
                planeWithExtent: extent,
                segments: vector_uint2(repeating: 1),
                geometryType: .triangles,
                allocator: MTKMeshBufferAllocator(device: device)
        )
        let mesh = OSMMesh(withMDLMesh: mdlMesh, device: device)

        if let textureName = textureName {
            let texture = try? MaterialUtils.loadTexture(imageName: textureName, device: device)
            mesh.materials[0].setTexture(texture!, semantic: .baseColor)
            mesh.materials[0].setTiling(tiling)
        }

        return mesh
    }

    static func getOrthoCamera(withSceneSize sceneSize: CGSize) -> OSMOrthographicCamera {
        let rectangle = CameraRect(
                left: -Float(sceneSize.width / 2.0),
                right: Float(sceneSize.width / 2.0),
                top: Float(sceneSize.height / 2.0),
                bottom: -Float(sceneSize.height / 2.0)
        )
        return OSMOrthographicCamera(
                rect: rectangle,
                near: -Float(sceneSize.width / 2.0) - 1.0,
                far: Float(sceneSize.width / 2.0) + 1.0
        )
    }

    static func getThirdPersonCameraNode(withSceneSize sceneSize: CGSize) -> OSMNode {
        let camera = OSMLookAtCamera()
        camera.near = 1.0
        camera.far = 2000.0
        let node = OSMNode(withCamera: camera)
        node.transform = float4x4(translation: [0.0, 40.0, -40.0])
        return OSMNode(withCamera: camera)
    }

    static func buildDefaultLights() -> OSMNode {
        let lightRoot = OSMNode(withMesh: nil)
        let lights = [
            Self.buildSunlight(withPosition: [-100.0, 50.0, -100]),
            Self.buildAmbientLight(),
            Self.buildPointLight(withPosition: [-5.0, 10.0, -5.0], color: [0.2, 0.0, 1.0]),
            Self.buildPointLight(withPosition: [5.0, 10.0, -5.0], color: [0.0, 1.0, 0.2])
        ]
        for lightNode in lights {
            lightRoot.add(childNode: lightNode)
        }
        return lightRoot
    }

    static func buildAmbientLight() -> OSMNode {
        OSMNode(withLight: AmbientLight(color: [1.0, 1.0, 1.0], intensity: 0.2))
    }

    static func buildPointLight(withPosition position: float3, color: float3) -> OSMNode {
        let light = Pointlight(color: color, attenuation: float3(1.0, 3.0, 4.0) / 100.0)
        let node = OSMNode(withLight: light)
        node.position = position
        return node
    }

    static func buildSunlight(withPosition position: float3) -> OSMNode {
        let light = Sunlight(color: [1.0, 1.0, 0.8], intensity: 1.0)
        let node = OSMNode(withLight: light)
        node.position = position
        return node
    }
}
