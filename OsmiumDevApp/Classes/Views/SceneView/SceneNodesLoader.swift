//
//  SceneNodesLoader.swift
//  OsmiumDevApp
//
//  Created by a.sechko on 19.01.2022.
//

import Foundation
import Osmium
import simd
import CoreImage

class SceneNodesLoader: ObservableObject {
    let device: MTLDevice
    @Published var nodes: [OSMNode] = []

    init(device: MTLDevice) {
        self.device = device
    }

    func load() {
        let lights = TestingUtils.buildDefaultLights()
        var nodes = [regularTestModel()]
        nodes.append(lights)

        let plane = TestingUtils.getPlane(
            withExtent: [256.0, 0.0, 256.0],
            device: device
        )
        plane.materials[0].setTexture(CIImage.checkerboard().makeTexture()!, semantic: .baseColor)
        plane.materials[0].setTiling([50.0, 50.0])
        nodes.append(OSMNode(withMesh: plane))

        self.nodes = nodes
    }

    private func regularTestModel() -> OSMNode {
        let asset = OSMAsset(withFileName: "Mechanical_Owl.usdz", device: device)
        let rootNode = OSMNode(withChildren: asset.nodes)
        let scale: Float = 1.0 / 30.0
        rootNode.transform = float4x4(translation: [0.0, 10.0, 0.0]) *
                float4x4(scaling: [scale, scale, scale]) *
                float4x4(rotation: [0.0, Float.pi, 0.0])
        return rootNode
    }

    private func largeCountTestModels() -> [OSMNode] {
        let slices = 5
        let rows = 5
        let columns = 5

        let side = Float(16.0)
        let padding = side / 2.0

        func offset(forNumber number: Int) -> Float {
            (side * Float(number) + padding * Float(number))
        }

        func length(forCount count: Int) -> Float {
            (side * Float(count) + padding * Float(count - 1))
        }

        let startX = -length(forCount: columns) / 2.0
        let startY = -length(forCount: rows) / 2.0
        let startZ = -length(forCount: slices) / 2.0

        var cubes = [OSMNode]()

        for s in 0..<slices {
            for r in 0..<rows {
                for c in 0..<columns {
                    let x = startX + offset(forNumber: c)
                    let y = startY + offset(forNumber: r)
                    let z = startZ + offset(forNumber: s)

                    let cubeMesh = TestingUtils.getCube(
                        withSide: CGFloat(side),
                        device: device
                    )
                    let node = OSMNode(withMesh: cubeMesh)
                    node.position = [x, y, z]
                    cubes.append(node)
                }
            }
        }

        return cubes
    }
}
