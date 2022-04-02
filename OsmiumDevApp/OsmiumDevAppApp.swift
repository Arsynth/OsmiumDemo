//
//  OsmiumDevAppApp.swift
//  OsmiumDevApp
//
//  Created by a.sechko on 09.01.2022.
//

import SwiftUI
import Osmium

@main
struct OsmiumDevAppApp: App {
    @StateObject var model = AppModel()
    var body: some Scene {
        WindowGroup {
            SceneView(withScene: OSMScene())
                .frame(
                    minWidth: 600.0,
                    idealWidth: nil,
                    maxWidth: .greatestFiniteMagnitude,
                    minHeight: 600.0,
                    idealHeight: nil,
                    maxHeight: .greatestFiniteMagnitude,
                    alignment: .center)
        }
    }
}
