//
//  TextFieldViewModifier.swift
//  eScooter
//
//  Created by Ana Vultur on 06.04.2022.
//

import SwiftUI

struct TextFieldClearButton: ViewModifier {
    @Binding var text: String
    @Binding var focused: Bool
    
    func body(content: Content) -> some View {
        HStack {
            content
            if !text.isEmpty {
                Button {
                    self.text = ""
                } label: {
                    if focused {
                        Image("close-circle")
                            .foregroundColor(Color(UIColor.opaqueSeparator))
                    }
                }
            }
        }
    }
}

