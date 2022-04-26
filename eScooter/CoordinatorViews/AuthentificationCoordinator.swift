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
    @StateObject var imageCoordinator: ImageCoordinator = ImageCoordinator()
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
        }, onDrivingLicenseVerification: {
            drivingLicenseVerification()
        }))
    }
    
    func login() {
        navigationViewModel.push(LoginView(onGetStarted: {
            registration()
        }, onForgotPassword: {
            forgotPassword()
        }, onMap: {
            onNext()
        }, onDrivingLicenseVerification: {
            drivingLicenseVerification()
        }))
    }
    
    func drivingLicenseVerification() {
        navigationViewModel.push(DrivingLicenseView(onBack: {
            //trebuie sa scot butonul de back
        }, onVerification: { image in
            handleVerification(image: image)
        }))
    }
    
    func handleVerification(image: Image) {
        API.uploadPicture(image: image, { response in
            print(response)
            //navigationViewModel.push(DrivingLicensePendingVerification())
            switch response {
            case .success:
                print("Success")
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
            //login()
            navigationViewModel.pop()
        }, onReset: {
            handleResetPassword()
        }))
    }
    
    func handleResetPassword() {
        navigationViewModel.push(ResetPasswordView(onForgotPassword: {
            //forgotPassword()
            navigationViewModel.pop()
        }, onLogin: {
            login()
        }))
    }
    
    //    func handleVerification() { //primesc imaginea
    //        //fac un alt coordinator care imi trimite imaginea(primeste parametru un NavigationStack)
    //        navigationViewModel.push(ValidLicense(onMap: {
    //            handleMap()
    //        }))
    //    }
    
    func failedToUpload(error: Error) {
        showError(error: "Failed to upload" + error.localizedDescription)
    }
    
    func loadingImage() {
        navigationViewModel.push(ValidLicense(onMap: {
            onNext()
        }))
    }
    
//    func handleMap() {
//        navigationViewModel.push(MapViewWithLocation(onMenu: {
//            handleMenu()
//        }))
//    }
    
//    func handleMenu() {
//        navigationViewModel.push(MenuView(onBack: {
//            handleMap()
//        }, onAccountSettings: {
//            handleAccount()
//        }, onChangePassword: {
//            handlePassword()
//        }))
//    }
//
//    func handleAccount() {
//        navigationViewModel.push(AccountSettingsView(onBack: {
//            navigationViewModel.pop()
//        }))
//    }
//
//    func handlePassword() {
//        navigationViewModel.push(ChangePasswordView(onBack: {
//            navigationViewModel.pop()
//        }))
//    }
    
}


