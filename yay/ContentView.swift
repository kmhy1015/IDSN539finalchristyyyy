//
//  ContentView.swift
//  yay
//
//  Created by KitahashiM on 2026/4/27.
//

import SwiftUI

struct ContentView: View {
    @Environment(AppModel.self) private var appModel
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace

    var body: some View {
        VStack(spacing: 24) {
            Text("Tilted Ring Instrument")
                .font(.largeTitle)

            Text("10 spheres in a 45°-tilted ring around you. Look at one and pinch to play a pentatonic note.")
                .font(.callout)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Button(buttonTitle) {
                Task { await toggleImmersiveSpace() }
            }
            .disabled(appModel.immersiveSpaceState == .inTransition)
            .controlSize(.large)
        }
        .padding(40)
    }

    private var buttonTitle: String {
        switch appModel.immersiveSpaceState {
        case .closed: return "Open Instrument"
        case .open: return "Close Instrument"
        case .inTransition: return "…"
        }
    }

    private func toggleImmersiveSpace() async {
        switch appModel.immersiveSpaceState {
        case .closed:
            appModel.immersiveSpaceState = .inTransition
            switch await openImmersiveSpace(id: appModel.instrumentSpaceID) {
            case .opened:
                break  // .onAppear in the immersive view sets state to .open
            case .userCancelled, .error:
                fallthrough
            @unknown default:
                appModel.immersiveSpaceState = .closed
            }
        case .open:
            appModel.immersiveSpaceState = .inTransition
            await dismissImmersiveSpace()
            // .onDisappear sets state to .closed
        case .inTransition:
            break
        }
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
        .environment(AppModel())
}
