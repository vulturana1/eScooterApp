//
//  ChangePasswordView.swift
//  eScooter
//
//  Created by Ana Vultur on 11.04.2022.
//

import SwiftUI

struct ChangePasswordView: View {
    @State private var newPassword: String = ""
    @State private var oldPassword: String = ""
    @State private var confirmNewPassword: String = ""
    let onBack: () -> Void
    var body: some View {
        ZStack {
            Color
                .white
                .ignoresSafeArea()
            VStack(alignment: .leading, spacing: 40) {
                BackButtonTopBar(title: "Change password", color: .init(red: 0.129, green: 0.043, blue: 0.314)) {
                    onBack()
                }
                textFields
                Spacer()
                saveEditsButton
            }
            .padding()
        }
    }
    
    var textFields: some View {
        VStack {
            SecureTextFieldView(text: $oldPassword, placeholder: "Old password", color: .init(red: 0.129, green: 0.043, blue: 0.314), last: false, secured: true, focused: false, comment: "")
            SecureTextFieldView(text: $newPassword, placeholder: "New password", color: .init(red: 0.129, green: 0.043, blue: 0.314), last: true, secured: true, focused: false, comment: "")
            SecureTextFieldView(text: $confirmNewPassword, placeholder: "Confirm new password", color: .init(red: 0.129, green: 0.043, blue: 0.314), last: true, secured: true, focused: false, comment: "")
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
        .disabled(newPassword.isEmpty ||  oldPassword.isEmpty || confirmNewPassword.isEmpty)
    }
    
    var buttonColor: Color {
        if newPassword.isEmpty ||  oldPassword.isEmpty || confirmNewPassword.isEmpty {
            return Color.init(red: 0.231, green: 0.067, blue: 0.349)
                .opacity(0)
        } else {
            return Color.init(red: 0.898, green: 0.188, blue: 0.384)
        }
    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView(onBack: {})
    }
}
