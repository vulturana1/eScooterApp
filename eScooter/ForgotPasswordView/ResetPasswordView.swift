//
//  ResetPasswordView.swift
//  eScooter
//
//  Created by Ana Vultur on 06.04.2022.
//

import SwiftUI

struct ResetPasswordView: View {
    @State private var newPassword: String = ""
    @State private var password: String = ""
    
    let onForgotPassword: () -> Void
    let onLogin: () -> Void
    
    var body: some View {
        ZStack {
            BackgroundView()
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    Text("Reset password")
                        .font(.custom("BaiJamjuree-Bold", size: 32))
                        .foregroundColor(.white)
                    Text("Enter the email address you're using for your account bellow and we'll send you a password reset link")
                        .font(.custom("BaiJamjuree-Medium", size: 16))
                        .foregroundColor(.white)
                        .opacity(0.5)
                    
                    textField
                    resetPassword
                   
                    Spacer()
                }
                .padding()
                .padding(.top, 40)
            }
        }
    }
    
    var backButtonBar: some View {
        HStack{
            Button {
                onForgotPassword()
            } label: {
                Image("left-arrow")
            }
            Spacer()
        }.padding(.top, 30)
    }
    
    var textField: some View {
        VStack {
            SecureTextFieldView(text: $password, placeholder: "New password", color: .white, last: false, secured: true, focused: false, comment: "")
            SecureTextFieldView(text: $newPassword, placeholder: "Confirm new password", color: .white, last: true, secured: true, focused: false, comment: nil)
        }
    }
    
    var resetPassword: some View {
        Button {
            onLogin()
        } label: {
            HStack {
                Text("Reset password")
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
            .cornerRadius(20)
        }
        .disabled(password.isEmpty || newPassword.isEmpty)
    }
    
    var buttonColor: Color {
        if password.isEmpty || newPassword.isEmpty {
            return Color.init(red: 0.231, green: 0.067, blue: 0.349)
                .opacity(0)
        } else {
            return Color.init(red: 0.898, green: 0.188, blue: 0.384)
        }
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView(onForgotPassword: {}, onLogin: {})
    }
}
