//
//  TopBar.swift
//  eScooter
//
//  Created by Ana Vultur on 26.04.2022.
//

import SwiftUI

struct TopBar: View {
    let title: String
    let color: Color
    
    var body: some View {
        ZStack(alignment: .leading) {
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

struct TopBar_Previews: PreviewProvider {
    static var previews: some View {
        TopBar(title: "Driving license", color: .init(red: 0.129, green: 0.043, blue: 0.314))
    }
}
