//
//  BackButtonTopBar.swift
//  eScooter
//
//  Created by Ana Vultur on 11.04.2022.
//

import SwiftUI

struct BackButtonTopBar: View {
    let title: String
    let color: Color
    let onBack: () -> Void
    
    var body: some View {
        ZStack(alignment: .leading) {
            Button {
                onBack()
            } label: {
                Image("left-arrow")
                    .renderingMode(.template)
                    .foregroundColor(color)
                    //.padding()
            }
            HStack {
                Spacer()
                Text(title)
                    .font(.custom("BaiJamjuree-SemiBold", size: 17))
                    .foregroundColor(color)
                Spacer()
            }
        }//.padding(.top, 30)
    }
}

struct BackButtonTopBar_Previews: PreviewProvider {
    static var previews: some View {
        BackButtonTopBar(title: "Driving license", color: .init(red: 0.129, green: 0.043, blue: 0.314), onBack: {})
    }
}
