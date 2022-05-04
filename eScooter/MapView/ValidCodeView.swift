//
//  ValidCodeView.swift
//  eScooter
//
//  Created by Ana Vultur on 28.04.2022.
//

import SwiftUI

struct ValidCodeView: View {
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                Spacer()
                Text("Unlock")
                    .font(.custom("BaiJamjuree-Bold", size: 32))
                    .foregroundColor(.white)
                Text("succesful")
                    .font(.custom("BaiJamjuree-Bold", size: 32))
                    .foregroundColor(.white)
                Spacer()
                Image("check")
                Spacer()
                Text("Please respect all the driving regulations and other participants in traffic while using our scooters")
                    .font(.custom("BaiJamjuree-Medium", size: 16))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .opacity(0.7)
                Spacer()
            }
        }
    }
}

struct ValidCodeView_Previews: PreviewProvider {
    static var previews: some View {
        ValidCodeView()
    }
}
