//
//  CoordinatorView.swift
//  eScooter
//
//  Created by Ana Vultur on 04.04.2022.
//

import SwiftUI
import NavigationStack

struct CoordinatorView: View {
    @StateObject var navigationViewModel: NavigationStack
    let onGetStarted: () -> Void
    
    var body: some View {
        NavigationStackView(navigationStack: self.navigationViewModel) {
            OnboardingView {
                registration()
            }
        }
    }
    
    func registration() {
        navigationViewModel.push(RegistrationView(onLogin: {
            login()
        }))
    }
    
    func login() {
        navigationViewModel.push(LoginView(onGetStarted: {
            registration()
        }))
    }
}

//struct CoordinatorView_Previews: PreviewProvider {
//    static var previews: some View {
//        CoordinatorView()
//    }
//}
