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
    @State private var emailAddress: String = ""
    @State private var username: String = ""
    @State private var password: String = ""
    @State var emailError: String = ""
    @State var usernameError: String = ""
    @State var passwordError: String = ""
    
    let onLogin: () -> Void
    
    var body: some View {
        ZStack {
            Color
                .init(red: 0.231, green: 0.067, blue: 0.349)
                .ignoresSafeArea()
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
            TextFieldView(text: $registerViewModel.email, placeholder: "Email address", color: .white, last: false)
            TextFieldView(text: $registerViewModel.username, placeholder: "Username", color: .white, last: false)
            SecureTextFieldView(text: $registerViewModel.password, placeholder: "Password", color: .white, last: true, secured: true)
        }
    }
    
    var logo: some View {
        ZStack {
            Image("logo")
            Image("name")
        }
    }
    
    var getStarted: some View {
        Button {
            //validate fields
            registerViewModel.register(email: registerViewModel.email, password: registerViewModel.password, username: registerViewModel.username)
        } label: {
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
        .disabled(registerViewModel.email.isEmpty || registerViewModel.username.isEmpty || registerViewModel.password.isEmpty)
        
    }
    
    var buttonColor: Color {
        if registerViewModel.email.isEmpty || registerViewModel.username.isEmpty || registerViewModel.password.isEmpty {
            return Color.init(red: 0.231, green: 0.067, blue: 0.349)
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

struct SafariView: UIViewControllerRepresentable {
    typealias UIViewControllerType = SFSafariViewController
    
    var url: URL
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ safariViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView(onLogin: {})
    }
}
