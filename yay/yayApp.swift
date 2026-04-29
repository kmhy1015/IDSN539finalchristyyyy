//
//  yayApp.swift
//  yay
//
//  Created by KitahashiM on 2026/4/27.
//

import SwiftUI

@main
struct yayApp: App {
    @State private var appModel = AppModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(appModel)
        }
        .windowStyle(.plain)
        .defaultSize(width: 0.45, height: 0.3, depth: 0.01, in: .meters)

        ImmersiveSpace(id: appModel.instrumentSpaceID) {
            InstrumentImmersiveView()
                .environment(appModel)
                .onAppear { appModel.immersiveSpaceState = .open }
                .onDisappear { appModel.immersiveSpaceState = .closed }
        }
        .immersionStyle(selection: .constant(.mixed), in: .mixed)
    }
}
