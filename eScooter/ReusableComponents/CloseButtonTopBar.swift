//
//  CloseButtonTopBar.swift
//  eScooter
//
//  Created by Ana Vultur on 28.04.2022.
//

import SwiftUI

struct CloseButtonTopBar: View {
    let title: String
    let color: Color
    let onClose: () -> Void
    
    var body: some View {
        ZStack(alignment: .leading) {
            Button {
                onClose()
            } label: {
                Image("close")
                    .renderingMode(.template)
                    .foregroundColor(color)
            }
            HStack {
                Spacer()
                Text(title)
                    .font(.custom("BaiJamjuree-SemiBold", size: 17))
                    .foregroundColor(color)
                Spacer()
            }
        }
    }
}

