//
//  ChangePasswordViewModel.swift
//  eScooter
//
//  Created by Ana Vultur on 28.04.2022.
//

import Foundation

class ChangePasswordViewModel: ObservableObject {
    @Published var oldPassword = ""
    @Published var newPassword = ""
    @Published var confirmNewPassword = ""
    
    func changePassword() {
        API.changePassword(oldPassword: oldPassword, newPassword: newPassword, { result in
            switch result {
            case .success:
                showSuccess(message: "Password changed")
                self.reset()
                break
            case .failure(_):
                showError(error: "Old password doesn't match")
                break
            }
        })
    }
    
    func reset() {
        self.oldPassword = ""
        self.newPassword = ""
        self.confirmNewPassword = ""
    }
    
    var passwordError: String = ""
    
    func validatePassword(password: String) -> Bool{
        let passwordPattern = "^.*(?=.{8,})(?=.*[A-Z])(?=.*[a-zA-Z])(?=.*\\d)|(?=.*[!#*$%&? ]).*$"
        let passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordPattern)
        if !passwordPred.evaluate(with: password) {
            self.passwordError = "Use a strong password(min. 8 characters, one capital letter, one lowercase letter, one digit and one special character)"
            return false
        }
        return true
    }
    
    func validate(password: String) -> String {
        if validatePassword(password: password) == true {
            return ""
        } else {
            let err = passwordError
            self.passwordError = ""
            return err
        }
    }
}
