//
//  ForgotPasswordView.swift
//  eScooter
//
//  Created by Ana Vultur on 06.04.2022.
//

import SwiftUI

struct ForgotPasswordView: View {
    @State private var emailAddress: String = ""
    let onLogin: () -> Void
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                backButtonBar
                
                VStack(alignment: .leading, spacing: 30) {
                    
                    Text("Forgot password")
                        .font(.custom("BaiJamjuree-Bold", size: 32))
                        .foregroundColor(.white)
                    Text("Enter the email address you're using for your account bellow and we'll send you a password reset link")
                        .font(.custom("BaiJamjuree-Medium", size: 16))
                        .foregroundColor(.white)
                        .opacity(0.5)
                    
                    TextFieldView(text: $emailAddress, placeholder: "Email address", color: .white, last: false, focused: false)
                    
                    sendResetLink
                    
                    Spacer()
                }
            }.padding()
        }
    }
    
    var backButtonBar: some View {
        HStack{
            Button {
                onLogin()
            } label: {
                Image("left-arrow")
            }
            Spacer()
        }.padding(.top, 30)
    }
    
    var sendResetLink: some View {
        Button {
            
        } label: {
            HStack {
                Text("Send Reset Link")
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
        .disabled(emailAddress.isEmpty)
    }
    
    var buttonColor: Color {
        if emailAddress.isEmpty {
            return Color.init(red: 0.231, green: 0.067, blue: 0.349)
                .opacity(0)
        } else {
            return Color.init(red: 0.898, green: 0.188, blue: 0.384)
        }
    }
}


struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView(onLogin: {})
    }
}
