//
//  CoordinatorView.swift
//  eScooter
//
//  Created by Ana Vultur on 04.04.2022.
//

import SwiftUI
import NavigationStack

struct AuthentificationCoordinator: View {
    @StateObject var navigationViewModel = NavigationStack(easing: Animation.linear)
    let onNext: () -> Void
    
    var body: some View {
        NavigationStackView(navigationStack: self.navigationViewModel, rootView: {
            OnboardingView {
                registration()
            }
        })
    }
    
    func registration() {
        navigationViewModel.push(RegistrationView(onLogin: {
            login()
        }, onDrivingLicenseVerification: { authResult in
            drivingLicenseVerification(authResult: authResult)
        }))
    }
    
    func login() {
        navigationViewModel.push(LoginView(onGetStarted: {
            registration()
        }, onForgotPassword: {
            forgotPassword()
        }, onMap: {
            onNext()
        }, onDrivingLicenseVerification: { authResult in
            drivingLicenseVerification(authResult: authResult)
        }))
    }
    
    func drivingLicenseVerification(authResult: Authentication) {
        guard let token = Session.shared.authToken else {
            return
        }
        Session.shared.invalidateSession()
        
        navigationViewModel.push(DrivingLicenseView( onVerification: { image in
            handleVerification(token: token, image: image, authResult: authResult)
        }))
    }
    
    func handleVerification(token: String, image: Image, authResult: Authentication) {
        navigationViewModel.push(DrivingLicensePendingVerification())
        
        API.uploadPicture(token: token, image: image, { response in
            print(response)
            switch response {
            case .success:
                print("Success")
                Session.shared.authToken = token
                loadingImage()
                break
            case .failure(let error):
                print("Failure")
                failedToUpload(error: error)
                break
            }
        })
    }
    
    func forgotPassword() {
        navigationViewModel.push(ForgotPasswordView(onLogin: {
            navigationViewModel.pop()
        }, onReset: {
            handleResetPassword()
        }))
    }
    
    func handleResetPassword() {
        navigationViewModel.push(ResetPasswordView(onForgotPassword: {
            navigationViewModel.pop()
        }, onLogin: {
            login()
        }))
    }
    
    func failedToUpload(error: Error) {
        showError(error: error)
        Session.shared.invalidateSession()
    }
    
    func loadingImage() {
        navigationViewModel.push(ValidLicense(onMap: {
            onNext()
        }))
    }
    
}


