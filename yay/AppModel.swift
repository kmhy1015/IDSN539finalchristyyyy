//
//  AppModel.swift
//  yay
//

import SwiftUI

@MainActor
@Observable
final class AppModel {
    let instrumentSpaceID = "InstrumentSpace"

    enum ImmersiveSpaceState {
        case closed
        case inTransition
        case open
    }

    var immersiveSpaceState: ImmersiveSpaceState = .closed
}
