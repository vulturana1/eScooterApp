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
    @State var focused: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .leading) {
                label
                VStack {
                    textField
                    underline
                }
            }
        }
        .autocapitalization(.none)
        .padding(.vertical, 10)
    }
    
    var label: some View {
        Text(placeholder)
            .foregroundColor(color)
            .opacity(0.6)
            .font(.custom("BaiJamjuree-Medium", size: text.isEmpty ? 16 : 12))
            .padding(.bottom, text.isEmpty ? 10 : 45)
            .animation(.easeInOut, value: text.isEmpty)
    }
    
    var textField: some View {
        TextField("", text: $text ,
                  onCommit: {
            focused = false
        })
        .onTapGesture {
            focused = true
        }
        .foregroundColor(color)
        .font(.custom("BaiJamjuree-Medium", size: 16))
        .modifier(TextFieldClearButton(text: $text, focused: $focused))

        //.submitLabel(last == true ? .done : .next)
    }
    
    var underline: some View {
        Rectangle()
            .frame(height: 1)
            .foregroundColor(color)
            .opacity(focused ? 1 : 0.3)
    }
}

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldView(text: .constant(""), placeholder: "Email", color: .black, last: false, focused: false)
    }
}
