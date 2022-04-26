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
        if Session.shared.isValidSession{
            handleMap()
                .onAppear {
                    print(Session.shared.authToken ?? "No token")
                }
        } else {
            handleAuthentification()
                .onAppear {
                    print(Session.shared.authToken ?? "No token")
                }
        }
        //AuthentificationCoordinator(navigationViewModel: navigationViewModel, onGetStarted: {})
        //        MenuCoordinator(navigationViewModel: navigationViewModel)
        //handleAuthentification()
    }
    
    func handleAuthentification() -> some View {
        //NavigationStackView(transitionType: .default, navigationStack: navigationViewModel) {
            AuthentificationCoordinator(navigationViewModel: navigationViewModel,
                                        onNext: {
                navigationViewModel.push(MapCoordinator(navigationViewModel: navigationViewModel,
                                                        onMenu: handleMenu))
            })
        //}
    }
    
    func handleMap() -> some View{
        NavigationStackView(transitionType: .default, navigationStack: navigationViewModel) {
            handleAuthentification()
        }
        .onAppear {
            navigationViewModel.push(MapCoordinator(navigationViewModel: navigationViewModel,
                                                    onMenu: handleMenu))
        }
    }
    
    func handleMenu() {
        navigationViewModel.push(MenuCoordinator(navigationViewModel: navigationViewModel))
    }
    
}

