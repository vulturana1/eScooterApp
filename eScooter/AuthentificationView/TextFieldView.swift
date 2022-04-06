//
//  TextFieldView.swift
//  eScooter
//
//  Created by Ana Vultur on 05.04.2022.
//

import SwiftUI

struct TextFieldView: View {
    @Binding var text: String
    let placeholder: String
    let color: Color
    let last: Bool
    
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
                    if last == true {
                        TextField("", text: $text)
                            .foregroundColor(color)
                            .font(.custom("BaiJamjuree-Medium", size: 16))
                            .modifier(TextFieldClearButton(text: $text))
                            .submitLabel(.done)
                    } else {
                        TextField("", text: $text)
                            .foregroundColor(color)
                            .font(.custom("BaiJamjuree-Medium", size: 16))
                            .modifier(TextFieldClearButton(text: $text))
                            .submitLabel(.next)
                    }
                    underline
                }
            }
        }
        .padding(.vertical, 10)
    }
    
    var underline: some View {
        Rectangle()
            .frame(height: 1)
            .foregroundColor(color)
    }
}

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldView(text: .constant(""), placeholder: "Email", color: .black, last: false)
    }
}
