//
//  LocationTopBar.swift
//  eScooter
//
//  Created by Ana Vultur on 13.04.2022.
//

import SwiftUI

struct LocationTopBar: View {
    @State var location: String
    @State var enabled: Bool
    
    let onMenu: () -> Void
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
                .mask(
                    LinearGradient(gradient: Gradient(colors: [Color.white, Color.white.opacity(0)]), startPoint: .top, endPoint: .bottom)
                )
//            Image("Rectangle")
//                .resizable()
//                .scaledToFit()
//                .ignoresSafeArea()
                
            VStack {
                HStack {
                    Button {
                        onMenu()
                    } label: {
                        Image("menu-button")
                    }
                    
                    Spacer()
                    Text(location)
                        .font(.custom("BaiJamjuree-SemiBold", size: 17))
                        .foregroundColor(Color.init(red: 0.129, green: 0.043, blue: 0.314))
                    Spacer()
                    Button {
                        self.enabled.toggle()
                    } label: {
                        if enabled {
                            Image("gps")
                        } else {
                            Image("no-gps")
                        }
                    }
                }
                Spacer()
            }
            .padding(.top, 40)
        }
        .ignoresSafeArea()
        .frame(maxHeight: 140)
    }
}

struct LocationTopBar_Previews: PreviewProvider {
    static var previews: some View {
        LocationTopBar(location: "Allow location", enabled: true, onMenu: {})
    }
}
