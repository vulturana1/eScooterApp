//
//  ChangePasswordView.swift
//  eScooter
//
//  Created by Ana Vultur on 11.04.2022.
//

import SwiftUI

struct ChangePasswordView: View {
    @State private var showErr = false
    @State var error: String = ""
    @ObservedObject var changePasswordViewModel = ChangePasswordViewModel()
    
    private enum Field: Int, Hashable {
        case oldPassword, newPassword, confirmNewPassword
    }
    @FocusState private var focusedField: Field?
    
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
            SecureTextFieldView(text: $changePasswordViewModel.oldPassword, placeholder: "Old password", color: .init(red: 0.129, green: 0.043, blue: 0.314), last: false, secured: true, focused: false, comment: "")
                .focused($focusedField, equals: .oldPassword)
                .submitLabel(.next)
                .onSubmit {
                    focusedField = .newPassword
                }
            SecureTextFieldView(text: $changePasswordViewModel.newPassword, placeholder: "New password", color: .init(red: 0.129, green: 0.043, blue: 0.314), last: false, secured: true, focused: false, comment: "")
                .focused($focusedField, equals: .newPassword)
                .submitLabel(.next)
                .onSubmit {
                    focusedField = .confirmNewPassword
                }
            SecureTextFieldView(text: $changePasswordViewModel.confirmNewPassword, placeholder: "Confirm new password", color: .init(red: 0.129, green: 0.043, blue: 0.314), last: true, secured: true, focused: false, comment: "")
                .focused($focusedField, equals: .confirmNewPassword)
                .submitLabel(.done)
        }
    }
    
    var saveEditsButton: some View {
        Button {
            if changePasswordViewModel.confirmNewPassword == changePasswordViewModel.newPassword {
                error = changePasswordViewModel.validate(password: changePasswordViewModel.newPassword)
                if !error.isEmpty {
                    showErr = true
                } else {
                    changePasswordViewModel.changePassword()
                }
            } else {
                showError(error: "New password and confirm new password is not the same")
            }
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
        .cornerRadius(20)
        .disabled(changePasswordViewModel.newPassword.isEmpty ||  changePasswordViewModel.oldPassword.isEmpty || changePasswordViewModel.confirmNewPassword.isEmpty)
        .alert(isPresented: $showErr) {
            Alert(title: Text("Change password error"),
                  message: Text(error),
                  dismissButton: .default(Text("Got it!")))
        }
    }
    
    var buttonColor: Color {
        if changePasswordViewModel.newPassword.isEmpty ||  changePasswordViewModel.oldPassword.isEmpty || changePasswordViewModel.confirmNewPassword.isEmpty {
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
