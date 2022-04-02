//
//  ContentView.swift
//  OsmiumDevApp
//
//  Created by a.sechko on 09.01.2022.
//

import SwiftUI
import Osmium

struct SceneView: View {
    @State private var viewModel: SceneViewModel

    var body: some View {
        OSMView(withScene: viewModel.scene, device: viewModel.device)
    }

    init(withScene scene: OSMScene) {
        viewModel = SceneViewModel(scene: scene)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SceneView(withScene: OSMScene())
    }
}
