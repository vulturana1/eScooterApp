//
//  RegistrationView.swift
//  eScooter
//
//  Created by Ana Vultur on 01.04.2022.
//

import SwiftUI
import SafariServices

struct RegistrationView: View {
    @ObservedObject var registerViewModel = RegisterViewModel()
    @State var error: String = ""
    @State private var showError: Bool = false
    @State var waiting = false
    
    private enum Field: Int, Hashable {
        case email, username, password
    }
    @FocusState private var focusedField: Field?
    
    let onLogin: () -> Void
    let onDrivingLicenseVerification: () -> Void
    
    var body: some View {
        ZStack {
            BackgroundView()
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    logo
                    Text("Let's get started")
                        .font(.custom("BaiJamjuree-Bold", size: 32))
                        .foregroundColor(.white)
                    Text("Sign up or login and start riding right away")
                        .font(.custom("BaiJamjuree-Medium", size: 20))
                        .foregroundColor(.white)
                        .opacity(0.6)
                    
                    textField
                    termsAndConditions()
                    getStarted
                    alreadyHaveAnAccount {
                        onLogin()
                    }
                    Spacer()
                }
                .padding()
            }
        }
    }
    
    var textField: some View {
        VStack(alignment: .leading, spacing: 10) {
            TextFieldView(text: $registerViewModel.email, placeholder: "Email address", color: .white, last: false,  focused: false)
                .focused($focusedField, equals: .email)
                .submitLabel(.next)
                .onSubmit {
                    focusedField = .username
                }
            TextFieldView(text: $registerViewModel.username, placeholder: "Username", color: .white, last: false, focused: false)
                .focused($focusedField, equals: .username)
                .submitLabel(.next)
                .onSubmit {
                    focusedField = .password
                }
            SecureTextFieldView(text: $registerViewModel.password, placeholder: "Password", color: .white, last: true, secured: true, focused: false, comment: "Use a strong password(min.8 characters and use symbols)")
                .focused($focusedField, equals: .password)
                .submitLabel(.done)
        }
    }
    
    var logo: some View {
        ZStack {
            Image("logo")
            Image("name")
        }.padding(.top)
    }
    
    var getStarted: some View {
        ZStack {
            Button {
                error = registerViewModel.validate(email: registerViewModel.email, password: registerViewModel.password, username: registerViewModel.username)
                if !error.isEmpty {
                    showError = true
                } else {
                    waiting = true
                    registerViewModel.register(callbackSuccess: {
                        onDrivingLicenseVerification()
                        
                    }
                                               , callbackFailure: {
                        waiting = false
                    })
                }
            } label: {
                if waiting {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .black))
                        .frame(maxWidth: .infinity, minHeight: 56, maxHeight: 56, alignment: .center)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.init(red: 0.898, green: 0.188, blue: 0.384).opacity(0.3), lineWidth: 1))
                        .padding(4)
                } else {
                    HStack {
                        Text("Get started")
                            .font(.custom("BaiJamjuree-SemiBold", size: 16))
                            .foregroundColor(.white)
                            .opacity(0.6)
                            .frame(maxWidth: .infinity, minHeight: 56, maxHeight: 56, alignment: .center)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.init(red: 0.898, green: 0.188, blue: 0.384), lineWidth: 2)
                            )
                    }
                    .background(buttonColor)
                    .cornerRadius(20)
                }
            }
            .disabled(registerViewModel.email.isEmpty || registerViewModel.username.isEmpty || registerViewModel.password.isEmpty || registerViewModel.waiting)
            .alert(isPresented: $showError) {
                Alert(title: Text("Registration error"),
                      message: Text(error),
                      dismissButton: .default(Text("Got it!")))
            }
            if registerViewModel.waiting {
                ProgressView()
                    .padding()
            }
        }
    }
    
    var buttonColor: Color {
        if registerViewModel.email.isEmpty || registerViewModel.username.isEmpty || registerViewModel.password.isEmpty {
            return Color.init(red: 0.231, green: 0.067, blue: 0.349)
                .opacity(0)
        } else {
            return Color.init(red: 0.898, green: 0.188, blue: 0.384)
        }
    }
}

struct alreadyHaveAnAccount: View {
    let onLogin: () -> Void
    var body: some View {
        HStack(alignment: .center, spacing: 3) {
            Text("You already have an account? You can")
                .font(.custom("BaiJamjuree-SemiBold", size: 12))
                .foregroundColor(.white)
                .opacity(0.8)
            Button {
                onLogin()
            } label: {
                Text("log in here")
                    .font(.custom("BaiJamjuree-SemiBold", size: 12))
                    .foregroundColor(.white)
                    .underline()
            }
        }
    }
}

struct termsAndConditions: View {
    @State var termsPressed = false
    @State var url = URL(string: "http://tapptitude.com")
    
    var body: some View{
        VStack(alignment: .leading) {
            Text("By continuing you agree to Move's")
                .font(.custom("BaiJamjuree-SemiBold", size: 12))
                .foregroundColor(.white)
                .opacity(0.8)
            HStack {
                Button {
                    termsPressed = true
                } label: {
                    Text("Terms and Conditions")
                        .font(.custom("BaiJamjuree-SemiBold", size: 12))
                        .foregroundColor(.white)
                        .underline()
                }
                .sheet(isPresented: $termsPressed) {
                    SafariView(url: self.url!)
                }
                
                Text("and")
                    .font(.custom("BaiJamjuree-SemiBold", size: 12))
                    .foregroundColor(.white)
                    .opacity(0.8)
                Button {
                    termsPressed = true
                } label: {
                    Text("Privacy Policy")
                        .font(.custom("BaiJamjuree-SemiBold", size: 12))
                        .foregroundColor(.white)
                        .underline()
                }
                .sheet(isPresented: $termsPressed) {
                    SafariView(url: self.url!)
                }
            }
        }
    }
}


