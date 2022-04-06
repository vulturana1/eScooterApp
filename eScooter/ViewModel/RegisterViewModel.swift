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
    
    @Published var emailError: String = ""
    @Published var usernameError: String = ""
    @Published var passwordError: String = ""
    
    func validateEmail(email: String) -> Bool{
        let emailPattern = #"^\S+@\S+\.\S+$"#
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailPattern)
        return emailPred.evaluate(with: email)
    }
    
    func validatePassword(password: String) -> Bool{
        //let passwordPattern = #"(?=.{8,})"# + #"(?=.*[A-Z])"# + #"(?=.*[a-z])"# + #"(?=.*\d)"# + #"(?=.*[ !$%&?._-])"#
        let passwordPattern = "^.*(?=.{8,})(?=.*[A-Z])(?=.*[a-zA-Z])(?=.*\\d)|(?=.*[!#*$%&? ]).*$"
        let passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordPattern)
        return passwordPred.evaluate(with: password)
    }
    
    func validateUser(email: String, password: String, username: String) -> Bool{
        if email.isEmpty {
            emailError = "Email is empty"
            return false
        } else if !validateEmail(email: email) {
            emailError = "Email is invalid"
            return false
        }
        
        if username.isEmpty {
            usernameError = "Username is empty"
            return false
        }
        
        if password.isEmpty {
            passwordError = "Password is empty"
            return false
        } else if !validatePassword(password: password) {
            passwordError = "Use a strong password(min. 8 characters, one capital letter, one lowercase letter, one digit and one special character)"
            return false
        }
        
        return true
    }
    
    func register(email: String, password: String, username: String) {
        if validateUser(email: email, password: password, username: username) == true {
            //register
            print("ok")
        } else {
            print(emailError + " " + passwordError + " " + usernameError)
            emailError = ""
            passwordError = ""
            usernameError = ""
        }
    }
    
}
