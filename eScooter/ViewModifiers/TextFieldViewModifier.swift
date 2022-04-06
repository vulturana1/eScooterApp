//
//  TextFieldViewModifier.swift
//  eScooter
//
//  Created by Ana Vultur on 06.04.2022.
//

import SwiftUI

struct TextFieldClearButton: ViewModifier {
    @Binding var text: String
    
    func body(content: Content) -> some View {
        HStack {
            content
            if !text.isEmpty {
                Button {
                    self.text = ""
                } label: {
                    Image("close-circle")
                        .foregroundColor(Color(UIColor.opaqueSeparator))
                }
            }
        }
    }
}

