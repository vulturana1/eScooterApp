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
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundColor(color)
                        .opacity(0.6)
                        .font(.custom("BaiJamjuree-Medium", size: 16))
                        .padding(.bottom, 10)
                } else {
                    Text(placeholder)
                        .foregroundColor(color)
                        .opacity(0.6)
                        .font(.custom("BaiJamjuree-Medium", size: 12))
                        .padding(.bottom, 45)
                }
                
                VStack {
                    HStack {
                        if secured == true {
                            SecureField("", text: $text)
                                .foregroundColor(color)
                                .font(.custom("BaiJamjuree-Medium", size: 16))
                                .submitLabel(.done)
                        } else {
                            TextField("", text: $text)
                                .foregroundColor(color)
                                .font(.custom("BaiJamjuree-Medium", size: 16))
                                .submitLabel(.next)
                        }
                        Spacer()
                        if !text.isEmpty {
                            Button(action: {
                                self.secured.toggle()
                            }) {
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
    var underline: some View {
        Rectangle()
            .frame(height: 1)
            .foregroundColor(color)
    }
}


//struct SecureTextFieldView_Previews: PreviewProvider {
//    static var previews: some View {
//        SecureTextFieldView()
//    }
//}
