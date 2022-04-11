//
//  ValidLicense.swift
//  eScooter
//
//  Created by Ana Vultur on 11.04.2022.
//

import SwiftUI

struct ValidLicense: View {
    let onMap: () -> Void
    var body: some View {
        ZStack() {
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack {
                Spacer()
                Image("check")
                Text("We've succesfuly validated your driving license")
                    .foregroundColor(.white)
                    .font(.custom("BaiJamjuree-Bold", size: 32))
                    .multilineTextAlignment(.center)
                    .padding()
                Spacer()
                findScootersButton
            }
            .padding(30)
        }
    }
    var findScootersButton: some View {
        Button {
            
        } label: {
            HStack {
                Text("Find scooters")
                    .font(.custom("BaiJamjuree-SemiBold", size: 16))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 56, maxHeight: 56, alignment: .center)
            }
            .background(Color.init(red: 0.898, green: 0.188, blue: 0.384))
            .cornerRadius(20)
        }
    }
}

struct ValidLicense_Previews: PreviewProvider {
    static var previews: some View {
        ValidLicense(onMap: {})
    }
}
