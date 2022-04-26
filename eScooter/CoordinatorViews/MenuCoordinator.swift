//
//  MenuCoordinator.swift
//  eScooter
//
//  Created by Ana Vultur on 16.04.2022.
//

import SwiftUI
import NavigationStack

struct MenuCoordinator: View {
    @StateObject var navigationViewModel: NavigationStack
    
    var body: some View {
        MenuView {
            navigationViewModel.pop()
        } onAccountSettings: {
            handleAccount()
        } onChangePassword: {
            handlePassword()
        }
        .onReceive(Session.shared.objectWillChange, perform: { _ in
            navigationViewModel.pop(to: .root)
        })
    }
    
    func handleAccount() {
        navigationViewModel.push(AccountSettingsView(onBack: {
            navigationViewModel.pop()
        }, onLogin: {
            navigationViewModel.pop(to: .root)
        }))
    }
    
    func handlePassword() {
        navigationViewModel.push(ChangePasswordView(onBack: {
            navigationViewModel.pop()
        }))
    }
}

