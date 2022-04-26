//
//  SwiftUIView.swift
//  eScooter
//
//  Created by Ana Vultur on 16.04.2022.
//

import SwiftUI

class ImageCoordinator: ObservableObject {
    @Published var image: Image?
    static var shared = ImageCoordinator()
}
