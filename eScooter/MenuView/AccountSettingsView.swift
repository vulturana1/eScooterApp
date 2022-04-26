//
//  AccountSettingsView.swift
//  eScooter
//
//  Created by Ana Vultur on 11.04.2022.
//

import SwiftUI

struct AccountSettingsView: View {
    @State private var email: String = ""
    @State private var username: String = ""
    
    let onBack: () -> Void
    let onLogin: () -> Void
    var body: some View {
        ZStack {
            Color
                .white
                .ignoresSafeArea()
            VStack(alignment: .leading, spacing: 40) {
                BackButtonTopBar(title: "Account", color: .init(red: 0.129, green: 0.043, blue: 0.314)) {
                    onBack()
                }
                textFields
                
                Spacer()
                HStack {
                    Spacer()
                    Image("logout")
                    Text("Log out")
                        .foregroundColor(.red)
                        .font(.custom("BaiJamjuree-Medium", size: 14))
                        .onTapGesture {
                            print("logout")
                            Session.shared.invalidateSession()
                            onLogin()
                        }
                    Spacer()
                }
                saveEditsButton
            }
            .padding()
        }
    }
    
    var textFields: some View {
        VStack {
            TextFieldView(text: $username, placeholder: "Username", color: .init(red: 0.129, green: 0.043, blue: 0.314), last: false, focused: false)
            TextFieldView(text: $email, placeholder: "Email Address", color: .init(red: 0.129, green: 0.043, blue: 0.314), last: true, focused: false)
        }
    }
    
    var saveEditsButton: some View {
        Button {
            // validate fields
        } label: {
            Text("Save edits")
                .font(.custom("BaiJamjuree-SemiBold", size: 16))
                .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
                .opacity(0.5)
                .frame(maxWidth: .infinity, minHeight: 56, maxHeight: 56, alignment: .center)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.init(red: 0.898, green: 0.188, blue: 0.384), lineWidth: 1)
                )
        }
        .background(buttonColor)
        .disabled(username.isEmpty ||  email.isEmpty)
    }
    
    var buttonColor: Color {
        if username.isEmpty ||  email.isEmpty {
            return Color.init(red: 0.231, green: 0.067, blue: 0.349)
                .opacity(0)
        } else {
            return Color.init(red: 0.898, green: 0.188, blue: 0.384)
        }
    }
}

struct AccountSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        AccountSettingsView(onBack: {}, onLogin: {})
    }
}
