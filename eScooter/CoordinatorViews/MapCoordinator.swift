//
//  MapCoordinator.swift
//  eScooter
//
//  Created by Ana Vultur on 16.04.2022.
//

import SwiftUI
import NavigationStack

struct MapCoordinator: View {
    let navigationViewModel: NavigationStack
    let onMenu: () -> Void
    
    var body: some View {
        MapViewWithLocation(onMenu: {
            onMenu()
        })
        .onReceive(Session.shared.objectWillChange, perform: { _ in
            navigationViewModel.pop(to: .root)
        })
    }
}

