//
//  RegisterViewModel.swift
//  eScooter
//
//  Created by Ana Vultur on 01.04.2022.
//

import Foundation

class RegisterViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var waiting = false
    
    var emailError: String = ""
    var passwordError: String = ""
    
    func validateEmail(email: String) -> Bool{
        let emailPattern = #"^\S+@\S+\.\S+$"#
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailPattern)
        return emailPred.evaluate(with: email)
    }
    
    func validatePassword(password: String) -> Bool{
        let passwordPattern = "^.*(?=.{8,})(?=.*[A-Z])(?=.*[a-zA-Z])(?=.*\\d)|(?=.*[!#*$%&? ]).*$"
        let passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordPattern)
        return passwordPred.evaluate(with: password)
    }
    
    func validateUser(email: String, password: String) -> Bool{
        if !validateEmail(email: email) {
            self.emailError = "Email is invalid"
            return false
        }

        if !validatePassword(password: password) {
            self.passwordError = "Use a strong password(min. 8 characters, one capital letter, one lowercase letter, one digit and one special character)"
            return false
        }
        
        return true
    }
    
    func validate(email: String, password: String, username: String) -> String {
        if validateUser(email: email, password: password) == true {
            return ""
        } else {
            let err1 = emailError
            let err2 = passwordError
            self.emailError = ""
            self.passwordError = ""
            return err1 + " " + err2
        }
    }
    
    func register(callbackSuccess: @escaping (Authentication) -> Void, callbackFailure: @escaping () -> Void) {
        if validateUser(email: email, password: password) == true {
            waiting = true
            API.register(email: self.email, username: self.username, password: self.password) { (result) in
                switch result {
                case .success(let authResult):
                    Session.shared.authToken = authResult.token
                    callbackSuccess(authResult)
                case .failure(let error):
                    showError(error: error)
                    callbackFailure()
                }
            }
            waiting = false
        }
    }
    
}
