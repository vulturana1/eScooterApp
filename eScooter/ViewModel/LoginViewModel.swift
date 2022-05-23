//
//  LoginViewModel.swift
//  eScooter
//
//  Created by Ana Vultur on 04.04.2022.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    func login(success callbackSuccess: @escaping () -> Void, failure callbackFailure: @escaping () -> Void, verification callbackVerification: @escaping (Authentication) -> Void) {
        API.login(email: self.email, password: self.password){ (result) in
            switch result {
            case .success(let authResult):
                print(authResult.token)
                Session.shared.authToken = authResult.token
                if authResult.customer.drivingLicense.isEmpty {
                    callbackVerification(authResult)
                } else {
                    callbackSuccess()
                    //Session.shared.authToken = authResult.token
                }
                
            case .failure(let error):
                print(error)
                showError(error: error)
                callbackFailure()
            }
        }
    }
}
