//
//  SecureTextFieldView.swift
//  eScooter
//
//  Created by Ana Vultur on 06.04.2022.
//

import SwiftUI

struct SecureTextFieldView: View {
    @Binding var text: String
    let placeholder: String
    let color: Color
    let last: Bool
    @State var secured: Bool
    @State var focused: Bool
    let comment: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .leading) {
                label
                VStack() {
                    HStack {
                        Group {
                            if secured == true {
                                SecureField("", text: $text, onCommit: {
                                    focused = false
                                })
                            } else {
                                TextField("", text: $text, onCommit: {
                                    focused = false
                                })
                            }
                        }
                        .onTapGesture {
                            focused = true
                        }
                        .foregroundColor(color)
                        .font(.custom("BaiJamjuree-Medium", size: 16))
                        .submitLabel(.done)
                        Spacer()
                        if !text.isEmpty {
                            Button {
                                self.secured.toggle()
                            } label: {
                                if secured {
                                    Image("eye-closed")
                                } else {
                                    Image("eye-opened")
                                }
                            }
                        }
                    }
                    underline
                }
            }
            .padding(.vertical, 10)
        }
    }
    
    var label: some View {
        Text(placeholder)
            .foregroundColor(color)
            .opacity(0.6)
            .font(.custom("BaiJamjuree-Medium", size: text.isEmpty ? 16 : 12))
            .padding(.bottom, text.isEmpty ? 25 : 60)
            .animation(.easeInOut, value: text.isEmpty)
    }
    
    var underline: some View {
        VStack(alignment: .leading, spacing: 4){
            Rectangle()
                .frame(height: 1)
                .foregroundColor(color)
                .opacity(focused ? 1 : 0.3)
            if let _comment = comment {
                Text(focused ? _comment : "")
                    .foregroundColor(.white)
                    .font(.custom("BaiJamjuree-Medium", size: 12))
            }
        }
    }
}

