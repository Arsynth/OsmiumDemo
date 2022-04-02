//
// Created by a.sechko on 16.01.2022.
//

import Foundation
import Osmium
import Combine

class SceneController {
    let scene: OSMScene
    let nodes = CurrentValueSubject<[OSMNode], Never>([])
    private var nodesCancellable: Cancellable?

    init(scene: OSMScene) {
        self.scene = scene

        scene.background = SkyboxGenerator.loadGeneratedSkyboxTexture(
            dimensions: [1024, 1024],
            device: kDefaultLibrary.device
        )
        setupSubcscriptions()
    }

    private func setupSubcscriptions() {
        nodesCancellable = nodes.sink { [weak self] nodes in
            self?.updateScene(withNodes: nodes)
        }
    }

    private func updateScene(withNodes nodes: [OSMNode]) {
        scene.rootNode.removeChildren()
        scene.rootNode.add(children: nodes)
    }
}
