//
//  DrivingLicensePendingVerification.swift
//  eScooter
//
//  Created by Ana Vultur on 11.04.2022.
//

import SwiftUI

struct DrivingLicensePendingVerification: View {
    var body: some View {
        ZStack() {
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("We are currently verifying your driving license")
                    .foregroundColor(.white)
                    .font(.custom("BaiJamjuree-Bold", size: 32))
                    .multilineTextAlignment(.center)
                    .padding()
                Image("loading")
                Spacer()
            }
        }
    }
}

struct DrivingLicensePendingVerification_Previews: PreviewProvider {
    static var previews: some View {
        DrivingLicensePendingVerification()
    }
}
