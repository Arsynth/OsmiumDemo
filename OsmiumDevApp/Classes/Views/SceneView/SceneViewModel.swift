//
//  SceneViewModel.swift
//  OsmiumDevApp
//
//  Created by a.sechko on 16.01.2022.
//

import Foundation
import Combine
import SwiftUI
import Osmium

class SceneViewModel: ObservableObject {
    let scene: OSMScene
    public var device: MTLDevice {
        nodesLoader.device
    }
    @Published var nodes: [OSMNode] = []

    private let nodesLoader: SceneNodesLoader
    private let sceneController: SceneController

    private var nodesCancellable: Cancellable?

    init(scene: OSMScene) {
        self.scene = scene

        nodesLoader = SceneNodesLoader(device: MTLCreateSystemDefaultDevice()!)
        sceneController = SceneController(scene: scene)

        setupBindings()
    }

    private func setupBindings() {
        nodesCancellable = nodesLoader.$nodes.sink { [weak self] nodes in
            self?.sceneController.nodes.send(nodes)
        }
        nodesLoader.load()
    }
}
