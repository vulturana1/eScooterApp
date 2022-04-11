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
        }, onDrivingLicenseVerification: {
            drivingLicenseVerification()
        }))
    }
    
    func login() {
        navigationViewModel.push(LoginView(onGetStarted: {
            registration()
        }, onForgotPassword: {
            forgotPassword()
        }))
    }
    
    func forgotPassword() {
        navigationViewModel.push(ForgotPasswordView(onLogin: {
            login()
        }))
    }
    
    func drivingLicenseVerification() {
        navigationViewModel.push(DrivingLicenseView(onBack: {
            registration()
        }))
    }
}

//struct CoordinatorView_Previews: PreviewProvider {
//    static var previews: some View {
//        CoordinatorView()
//    }
//}
