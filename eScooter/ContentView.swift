//
//  ContentView.swift
//  eScooter
//
//  Created by Ana Vultur on 25.03.2022.
//

import SwiftUI
import NavigationStack

struct ContentView: View {
    var navigationViewModel: NavigationStack = NavigationStack(easing: Animation.linear)
    
    var body: some View {
        CoordinatorView(navigationViewModel: navigationViewModel, onGetStarted: {})
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
