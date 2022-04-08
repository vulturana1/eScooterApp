//
//  LoginView.swift
//  eScooter
//
//  Created by Ana Vultur on 01.04.2022.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var loginViewModel = LoginViewModel()
    @State private var emailAddress: String = ""
    @State private var username: String = ""
    @State private var password: String = ""
    
    let onGetStarted: () -> Void
    
    var body: some View {
        ZStack {
            Color
                .init(red: 0.231, green: 0.067, blue: 0.349)
                .ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    logo
                    Text("Login")
                        .font(.custom("BaiJamjuree-Bold", size: 32))
                        .foregroundColor(.white)
                    Text("Enter your account credentials and start riding away")
                        .font(.custom("BaiJamjuree-Medium", size: 20))
                        .foregroundColor(.white)
                        .opacity(0.5)
                    
                    textField
                    forgotYourPassword()
                    login
                    dontHaveAnAccount {
                        onGetStarted()
                    }
                    Spacer()
                }
                .padding()
            }
        }
    }
    
    var textField: some View {
        VStack {
            TextFieldView(text: $loginViewModel.email, placeholder: "Email address", color: .white, last: false, focused: false)
            SecureTextFieldView(text: $loginViewModel.password, placeholder: "Password", color: .white, last: true, secured: true, focused: false, comment: "")
        }
    }
    
    var logo: some View {
        ZStack {
            Image("logo")
            Image("name")
        }
    }
    
    var login: some View {
        Button {
            // validate fields
        } label: {
            Text("Login")
                .font(.custom("BaiJamjuree-SemiBold", size: 16))
                .foregroundColor(.white)
                .opacity(0.5)
                .frame(maxWidth: .infinity, minHeight: 56, maxHeight: 56, alignment: .center)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.init(red: 0.898, green: 0.188, blue: 0.384), lineWidth: 1)
                )
        }
        .background(buttonColor)
        .disabled(loginViewModel.email.isEmpty ||  loginViewModel.password.isEmpty)
    }
    
    var buttonColor: Color {
        if loginViewModel.email.isEmpty || loginViewModel.password.isEmpty {
            return Color.init(red: 0.231, green: 0.067, blue: 0.349)
        } else {
            return Color.init(red: 0.898, green: 0.188, blue: 0.384)
        }
    }
}

struct dontHaveAnAccount: View {
    let onGetStarted: () -> Void
    var body: some View {
        HStack(alignment: .center, spacing: 3) {
            Text("Don't have an account? You can")
                .font(.custom("BaiJamjuree-SemiBold", size: 12))
                .foregroundColor(.white)
                .opacity(0.5)
            Button {
                onGetStarted()
            } label: {
                Text("start with one here")
                    .font(.custom("BaiJamjuree-SemiBold", size: 12))
                    .foregroundColor(.white)
                    .underline()
            }
        }
    }
}

struct forgotYourPassword: View {
    var body: some View{
        VStack(alignment: .leading) {
            Text("Forgot your password?")
                .font(.custom("BaiJamjuree-SemiBold", size: 12))
                .foregroundColor(.white)
                .underline()
                .opacity(0.5)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(onGetStarted: {})
    }
}
